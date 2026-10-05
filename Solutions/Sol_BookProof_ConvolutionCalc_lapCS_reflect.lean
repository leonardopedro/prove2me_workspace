-- Generated from ChapterConvolutionCalc.lean — solution of BookProof.ConvolutionCalc.lapCS_reflect
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
import Theorems.Thm_BookProof_ConvolutionCalc_dcoord_reflect
import Theorems.Thm_BookProof_QgOneParticleCc_contDiff_dcoord
open BookProof.ConvolutionCalc




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {g : Vd d → ℂ} (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (x : Vd d)
    (S : Finset (Fin d)) (y : Vd d) :
    lapCS S (fun y => g (x - y)) y = lapCS S g (x - y) := by

  refine Finset.sum_congr rfl fun j _ => ?_
  have h1 : dcoord j (fun y => g (x - y)) = fun y => (-(dcoord j g)) (x - y) := by
    rw [dcoord_reflect hg x j]
    funext w
    simp
  have h2 : dcoord j (fun y => (-(dcoord j g)) (x - y))
      = fun y => -(dcoord j (-(dcoord j g)) (x - y)) :=
    dcoord_reflect ((contDiff_dcoord hg j).neg) x j
  rw [h1, h2]
  have h3 : dcoord j (-(dcoord j g)) = -(dcoord j (dcoord j g)) := by
    funext w
    simp only [dcoord, Pi.neg_apply]
    rw [fderiv_neg]
    simp
  rw [h3]
  simp
