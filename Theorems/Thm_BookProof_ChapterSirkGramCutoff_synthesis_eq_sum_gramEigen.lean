-- Generated from ChapterSirkGramCutoff.lean — theorem BookProof.ChapterSirkGramCutoff.synthesis_eq_sum_gramEigen
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


theorem BookProof.ChapterSirkGramCutoff.synthesis_eq_sum_gramEigen (c : EuclideanSpace ℂ (Fin m)) :
    synthesis w c = ∑ k, ⟪u k, c⟫_ℂ • synthesis w (u k) := by sorry
