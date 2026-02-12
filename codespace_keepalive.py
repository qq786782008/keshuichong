#!/usr/bin/env python3
import requests
import json
import time
from datetime import datetime
import os
import subprocess

class CodespaceKeepAlive:
    def __init__(self):
        self.base_url = "https://turbo-garbanzo-j66rvwrjvg6h45j-18789.app.github.dev/chat"
        self.session = requests.Session()
        
    def trigger_keepalive(self):
        """触发keep-alive操作"""
        timestamp = datetime.utcnow().isoformat()
        
        # 方法1: 触发OpenClaw代理
        try:
            response = self.session.post(
                f"{self.base_url}",
                json={
                    "action": "keepalive",
                    "timestamp": timestamp,
                    "source": "python-keepalive"
                },
                timeout=10
            )
            print(f"OpenClaw keepalive: {response.status_code}")
        except Exception as e:
            print(f"OpenClaw keepalive failed: {e}")
        
        # 方法2: 系统级保持活跃
        try:
            # 创建/更新临时文件
            with open("/tmp/codespace-keepalive.log", "a") as f:
                f.write(f"{timestamp}\n")
            
            # Git操作
            self.git_keepalive()
            
            # 内存文件更新
            self.memory_keepalive(timestamp)
            
        except Exception as e:
            print(f"System keepalive failed: {e}")
    
    def git_keepalive(self):
        """执行Git操作保持活跃"""
        try:
            # 添加文件
            subprocess.run(["git", "add", "."], capture_output=True, timeout=5)
            
            # 提交（如果有更改）
            result = subprocess.run(
                ["git", "commit", "-m", f"Keep-alive commit - {datetime.utcnow().isoformat()}"],
                capture_output=True, timeout=5
            )
            
            # 推送（如果有更改）
            if result.returncode == 0:
                subprocess.run(["git", "push"], capture_output=True, timeout=10)
                
        except subprocess.TimeoutExpired:
            print("Git operations timed out")
        except Exception as e:
            print(f"Git operations failed: {e}")
    
    def memory_keepalive(self, timestamp):
        """更新内存文件"""
        try:
            from pathlib import Path
            
            memory_dir = Path("memory")
            memory_dir.mkdir(exist_ok=True)
            
            today_file = memory_dir / f"{datetime.utcnow().strftime('%Y-%m-%d')}.md"
            
            with open(today_file, "a", encoding="utf-8") as f:
                f.write(f"\n## Keep-alive Update\n")
                f.write(f"- Time: {timestamp}\n")
                f.write(f"- Action: Codespace keep-alive triggered\n")
                
        except Exception as e:
            print(f"Memory update failed: {e}")

def main():
    """主函数"""
    keep_alive = CodespaceKeepAlive()
    
    print(f"[{datetime.utcnow().isoformat()}] Starting keep-alive process")
    
    try:
        keep_alive.trigger_keepalive()
        print(f"[{datetime.utcnow().isoformat()}] Keep-alive completed successfully")
        
    except Exception as e:
        print(f"[{datetime.utcnow().isoformat()}] Keep-alive failed: {e}")
    
    print("=" * 50)

if __name__ == "__main__":
    main()