-- Generated from ChapterAttentionLocality.lean — theorem BookProof.ChapterAttentionLocality.mem_window
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionLocality
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionLocality

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionLocality.mem_window {d : Fin m → ℝ} {R : ℝ} {l : Fin m} : l ∈ window d R ↔ d l < R := by sorry
