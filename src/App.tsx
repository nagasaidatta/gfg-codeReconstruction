import { Routes, Route, Navigate } from 'react-router-dom'
import Student from './pages/Student'
import Exam from './pages/Exam'
import Result from './pages/Result'
import AdminLogin from './pages/AdminLogin'
import Dashboard from './pages/Dashboard'
export default function App() { return <Routes><Route path="/" element={<Student/>}/><Route path="/exam/:attemptId" element={<Exam/>}/><Route path="/result/:attemptId" element={<Result/>}/><Route path="/admin/login" element={<AdminLogin/>}/><Route path="/admin" element={<Dashboard/>}/><Route path="*" element={<Navigate to="/" replace/>}/></Routes> }
