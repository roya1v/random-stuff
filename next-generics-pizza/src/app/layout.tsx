import "./globals.css";

import { type Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Generic's Pizza",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>
        <div className="flex justify-between p-4 shadow-lg">
          <Link className="" href={"/"}>
            Welcome to Generic's Pizza!
          </Link>
          <Link href={"/cart"}>Cart</Link>
        </div>
        {children}
      </body>
    </html>
  );
}
