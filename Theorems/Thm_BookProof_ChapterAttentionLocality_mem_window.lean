-- Generated from ChapterAttentionLocality.lean — theorem BookProof.ChapterAttentionLocality.mem_window
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionLocality
open BookProof.ChapterAttentionLocality


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionLocality.mem_window {d : Fin m → ℝ} {R : ℝ} {l : Fin m} : l ∈ window d R ↔ d l < R := by sorry
