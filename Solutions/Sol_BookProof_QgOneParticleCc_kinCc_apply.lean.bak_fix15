-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.kinCc_apply
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
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
theorem solution (f : ccSchwartz (Vd d)) :
    kinCc d (ccEquiv (Vd d) f)
      = (kinOp d (f : 𝓢(Vd d, ℂ))).toLp 2 (volume : Measure (Vd d)) := by

  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := Vd d)) (ccEquiv (Vd d) f)
      = schwartzEquiv (Vd d) ((f : 𝓢(Vd d, ℂ))) := Subtype.ext rfl
  simp only [kinCc, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
