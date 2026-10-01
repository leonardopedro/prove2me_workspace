-- Generated from ChapterSirkGramCutoff.lean — theorem BookProof.ChapterSirkGramCutoff.mem_range_retainedEmbedding
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramWhitening
open BookProof.ChapterSirkGramCutoff

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}


noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap


theorem BookProof.ChapterSirkGramCutoff.mem_range_retainedEmbedding {d : ℕ} {e : Fin d → Fin m}
    (hpos : ∀ j : Fin d, 0 < lam (e j)) (j : Fin d) :
    ∃ z, retainedEmbedding w u lam e z = synthesis w (u (e j)) := by sorry
