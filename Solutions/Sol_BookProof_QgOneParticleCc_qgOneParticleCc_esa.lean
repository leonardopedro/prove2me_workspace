-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.qgOneParticleCc_esa
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_ccHam_essentiallySelfAdjoint_of_core
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_of_le_harm
import Theorems.Thm_BookProof_HermiteQuadraticEsa_harmonic_add_subquadratic_essentiallySelfAdjoint
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {V : Vd d → ℝ} {a b : ℝ}
    (hVs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hV : ∀ x, |V x| ≤ a * harmW x + b) :
    EssentiallySelfAdjointOn (ccDomain (Vd d))
      (ccHam (fun x => harmW x + V x) ((contDiff_harmW d).add hVs)) := by

  have hVc : Continuous V := hVs.continuous
  have hsc : Continuous fun x : Vd d => harmW x + V x := continuous_harmW.add hVc
  have hsb : ExpBounded fun x : Vd d => harmW x + V x := by
    refine expBounded_of_le_harm (a := 1 + a) (b := b) (by linarith) hb fun x => ?_
    have hharm : (0 : ℝ) ≤ harmW x := by unfold harmW; positivity
    have h := hV x
    have h2 := abs_add_le (harmW x) (V x)
    have h3 : |harmW x| = harmW x := abs_of_nonneg hharm
    rw [h3] at h2
    nlinarith
  exact ccHam_essentiallySelfAdjoint_of_core _ _ hsc hsb
    (harmonic_add_subquadratic_essentiallySelfAdjoint hVc ha ha1 hb hV hsc hsb)
