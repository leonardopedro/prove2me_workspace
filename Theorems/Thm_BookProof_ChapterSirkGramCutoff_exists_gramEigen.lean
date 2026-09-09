-- Generated from ChapterSirkGramCutoff.lean — theorem BookProof.ChapterSirkGramCutoff.exists_gramEigen
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
open BookProof.ChapterSirkGramCutoff









noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterSirkGramCutoff.exists_gramEigen {m : ℕ} (w : Fin m → E) :
    ∃ (u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (lam : Fin m → ℝ),
      IsGramEigen w u lam := by sorry
