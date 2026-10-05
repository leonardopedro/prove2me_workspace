-- Generated from ChapterConvolutionCalc.lean — solution of BookProof.ConvolutionCalc.dcoord_reflect
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
open BookProof.ConvolutionCalc




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {g : Vd d → ℂ} (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (x : Vd d)
    (j : Fin d) : dcoord j (fun y => g (x - y)) = fun y => -(dcoord j g (x - y)) := by

  funext y
  have hA : @HasFDerivAt ℝ _ (Vd d) (PiLp.normedAddCommGroup 2 fun _ : Fin d => ℝ).toAddCommGroup
      ((PiLp.normedSpace 2 ℝ fun _ : Fin d => ℝ).toModule)
      ((PiLp.instPseudoMetricSpace 2 fun _ : Fin d => ℝ).toUniformSpace.toTopologicalSpace)
      (Vd d) (PiLp.normedAddCommGroup 2 fun _ : Fin d => ℝ).toAddCommGroup
      ((PiLp.normedSpace 2 ℝ fun _ : Fin d => ℝ).toModule)
      ((PiLp.instPseudoMetricSpace 2 fun _ : Fin d => ℝ).toUniformSpace.toTopologicalSpace)
      (fun y : Vd d => x - y) (-(ContinuousLinearMap.id ℝ (Vd d))) y := by
    have h := (hasFDerivAt_const (𝕜 := ℝ) x y).sub (hasFDerivAt_id y)
    convert h using 1
    · funext z; simp
    · ext z; simp
  have hgd : HasFDerivAt g (fderiv ℝ g (x - y)) (x - y) :=
    (hg.differentiable (by simp)).differentiableAt.hasFDerivAt
  have hcomp : HasFDerivAt (fun y : Vd d => g (x - y))
      ((fderiv ℝ g (x - y)).comp (-(ContinuousLinearMap.id ℝ (Vd d)))) y := hgd.comp y hA
  simp only [dcoord]
  rw [hcomp.fderiv]
  simp
