-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.lapC_mul
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_dcoord
import Theorems.Thm_BookProof_QgOneParticleCc_dcoord_add
import Theorems.Thm_BookProof_QgOneParticleCc_dcoord_mul
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
theorem solution {u v : Vd d → ℂ} (hu : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) u)
    (hv : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) v) (x : Vd d) :
    lapC (fun y => u y * v y) x
      = u x * lapC v x + v x * lapC u x
        + 2 * ∑ j : Fin d, dcoord j u x * dcoord j v x := by

  have hstep : ∀ j : Fin d, dcoord j (dcoord j (fun y => u y * v y)) x
      = u x * dcoord j (dcoord j v) x + v x * dcoord j (dcoord j u) x
        + 2 * (dcoord j u x * dcoord j v x) := by
    intro j
    rw [dcoord_mul hu hv j]
    rw [dcoord_add (hu.mul (contDiff_dcoord hv j)) (hv.mul (contDiff_dcoord hu j)) j]
    rw [dcoord_mul hu (contDiff_dcoord hv j) j, dcoord_mul hv (contDiff_dcoord hu j) j]
    ring
  simp only [lapC, hstep, Finset.sum_add_distrib, ← Finset.mul_sum]
