-- Generated from ChapterSirkGramCutoff.lean — theorem BookProof.ChapterSirkGramCutoff.defect_le_sqrt_cutoff_retained
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
open BookProof.ChapterSirkGramCutoff









noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

theorem BookProof.ChapterSirkGramCutoff.defect_le_sqrt_cutoff_retained (heig : IsGramEigen w u lam) {tol : ℝ}
    {d : ℕ} {e : Fin d → Fin m} (he : Function.Injective e)
    (hpos : ∀ j : Fin d, 0 < lam (e j))
    (hcut : ∀ k ∉ (Finset.univ.image e), lam k ≤ tol) (i : Fin m) :
    ‖w i - retainedEmbedding w u lam e
        (adjoint (retainedEmbedding w u lam e) (w i))‖ ≤ Real.sqrt tol := by sorry
