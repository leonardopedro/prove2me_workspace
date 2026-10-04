-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.collisionProb_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionCollision.collisionProb_pos {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) : 0 < collisionProb p := by sorry
