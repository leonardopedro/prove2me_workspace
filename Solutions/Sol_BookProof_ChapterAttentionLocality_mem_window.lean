-- Generated from ChapterAttentionLocality.lean — solution of BookProof.ChapterAttentionLocality.mem_window
import Mathlib
import Definitions.Def_ChapterAttentionLocality
open BookProof.ChapterAttentionLocality



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {d : Fin m → ℝ} {R : ℝ} {l : Fin m} : l ∈ window d R ↔ d l < R := by

  simp [window]
