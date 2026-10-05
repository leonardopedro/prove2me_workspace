-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.ymIdx_injective
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
open BookProof.YangMillsNonAbelianEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {d : ℕ}
variable {d k r : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective ymIdx := by

  intro m m' h
  have := congrArg Fin.val h
  simp only [ymIdx, idxA, decodeSpace, decodeColor] at this
  apply Fin.ext
  omega
