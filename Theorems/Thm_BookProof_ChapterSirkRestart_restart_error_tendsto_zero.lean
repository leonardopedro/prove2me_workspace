-- Generated from ChapterSirkRestart.lean — theorem BookProof.ChapterSirkRestart.restart_error_tendsto_zero
import Mathlib
import Definitions.Def_ChapterSirkRestart
open BookProof.ChapterSirkRestart

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

m_nonneg _)

theorem BookProof.ChapterSirkRestart.restart_error_tendsto_zero (C Dmin h nv : ℝ) (n : ℕ) (hh : 0 < h) :
    Tendsto (fun m : ℕ => (n : ℝ) * sirkBound C Dmin h nv m) at := by sorry
