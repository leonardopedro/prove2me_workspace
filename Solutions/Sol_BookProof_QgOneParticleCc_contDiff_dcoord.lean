-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.contDiff_dcoord
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
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
theorem solution {u : Vd d → ℂ} (hu : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) u)
    (j : Fin d) : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (dcoord j u) := by

  have hfd : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y : Vd d => fderiv ℝ u y) :=
    hu.fderiv_right (m := ((⊤ : ℕ∞) : WithTop ℕ∞)) le_rfl
  exact (ContinuousLinearMap.apply ℝ ℂ (kinDir d j)).contDiff.comp hfd
