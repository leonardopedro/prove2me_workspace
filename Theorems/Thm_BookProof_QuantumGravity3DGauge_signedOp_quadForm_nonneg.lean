-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.signedOp_quadForm_nonneg
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterFarisLavineCore
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

theorem BookProof.QuantumGravity3DGauge.signedOp_quadForm_nonneg {n m : ℕ} {kappa : Fin n → ℝ} {pi : Fin n → D →ₗ[ℂ] D}
    {Bf : Fin m → D →ₗ[ℂ] D} (hk : ∀ i, 0 ≤ kappa i)
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : D) :
    0 ≤ quadForm (signedOp kappa pi Bf) x := by sorry
