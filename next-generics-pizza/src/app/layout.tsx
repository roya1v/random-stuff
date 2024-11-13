import "~/styles/globals.css";

import { GeistSans } from "geist/font/sans";
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
        <div className="text-5xl">
          <Link href={"/"}>Welcome to Generic's Pizza!</Link>
          <Link href={"/cart"}>Cart</Link>
        </div>
        {children}
      </body>
    </html>
  );
}
