-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.dcoord_add
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_differentiableAt_of_contDiffTop
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
    (hv : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) v) (j : Fin d) :
    dcoord j (fun y => u y + v y) = fun x => dcoord j u x + dcoord j v x := by

  funext x
  simp only [dcoord]
  have h := ((differentiableAt_of_contDiffTop hu x).hasFDerivAt.add
    (differentiableAt_of_contDiffTop hv x).hasFDerivAt).fderiv
  change (fderiv ℝ (u + v) x) (kinDir d j) = _
  rw [h]
  simp
