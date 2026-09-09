-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.sirk_end_to_end_truncated_gram
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_norm_defect_synthesis_le
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m d : ℕ} (w : Fin m → E)
    (V : EuclideanSpace ℂ (Fin d) →L[ℂ] E)
    (rX : E →L[ℂ] E) (rB : EuclideanSpace ℂ (Fin d) →L[ℂ] EuclideanSpace ℂ (Fin d))
    (flow psiX : E →L[ℂ] E) (psiB : EuclideanSpace ℂ (Fin d) →L[ℂ] EuclideanSpace ℂ (Fin d))
    (C Dmin hrate : ℝ) (k : ℕ) {delta : ℝ}
    (hViso : ∀ x : EuclideanSpace ℂ (Fin d), ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖ContinuousLinearMap.adjoint V v‖ ≤ ‖v‖)
    (hflow : flow = psiX)
    (hcx1 : ‖psiX - rX‖ ≤ C * (Real.exp (-(hrate * k)) * Dmin))
    (hcx2 : ‖psiB - rB‖ ≤ C * (Real.exp (-(hrate * k)) * Dmin))
    (hdelta : ∀ i, ‖w i - V (ContinuousLinearMap.adjoint V (w i))‖ ≤ delta)
    (c : EuclideanSpace ℂ (Fin m))
    (hexact : rX (V (ContinuousLinearMap.adjoint V (synthesis w c)))
      = V (rB (ContinuousLinearMap.adjoint V
        (V (ContinuousLinearMap.adjoint V (synthesis w c))))))
    (hproj : ContinuousLinearMap.adjoint V (V (ContinuousLinearMap.adjoint V (synthesis w c)))
      = ContinuousLinearMap.adjoint V (synthesis w c)) :
    ‖flow (synthesis w c)
        - BookProof.ChapterSirkEndToEnd.sirkApprox V psiB (synthesis w c)‖
      ≤ BookProof.ChapterH6.sirkBound C Dmin hrate ‖synthesis w c‖ k
        + ‖rX‖ * (delta * (Real.sqrt m * ‖c‖)) := by

  have hbase := BookProof.ChapterSirkTruncation.sirk_end_to_end_truncated V rX rB flow psiX
    psiB C Dmin hrate k hViso hVadj hflow hcx1 hcx2 (synthesis w c) hexact hproj
  refine hbase.trans ?_
  exact add_le_add_right
    (mul_le_mul_of_nonneg_left (norm_defect_synthesis_le w V hdelta c) (norm_nonneg rX))
    (BookProof.ChapterH6.sirkBound C Dmin hrate ‖synthesis w c‖ k)
