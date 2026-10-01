-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qg3DElliptic_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

) :=
  smul_symmetricOn _ (qgMom_symmetricOn Φ j)

theorem BookProof.QuantumGravity3DGauge.qg3DElliptic_hashimoto_selects :
    ∃ (Dom : Submodule ℂ (L2d 84)) (A : Dom →ₗ[ℂ] L2d 84),
      IsPositiveSelfAdjointExtension (qg3DEllipticHamiltonian (coreRepPoly 84)) A :=
  friedrichs_extension_exists
    ⟨polyGaussCore, qg3DEllipticHamiltonian (coreRepPoly 84),
      qg3DElliptic_symmetricOn _, qg3DElliptic_quadForm_nonneg _⟩
    polyGaussCore_dense

/-- **F.8 — the Hashimoto/SIRK shift-invert limit selects exactly that Friedrichs
extension** of the elliptic sector, on the fini := by sorry
