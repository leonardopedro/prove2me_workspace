-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qg3DElliptic_hashimoto_selects
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}

theorem BookProof.QuantumGravity3DGauge.qg3DElliptic_hashimoto_selects (e : ℕ ≃ (Fin 84 →₀ ℕ)) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ (L2d 84)) (A : Dom →ₗ[ℂ] L2d 84) (R : L2d 84 →L[ℂ] L2d 84),
      IsPositiveSelfAdjointExtension (qg3DEllipticHamiltonian (coreRepBasis e)) A ∧
        IsShiftInvert A γ R ∧ IsSelfAdjoint R ∧
        (∀ u : L2d 84, Filter.Tendsto (fun k : ℕ => galerkinCompression R (coreBasis e) k u)
          Filter.atTop (nhds (R u))) ∧
        (∀ (Dom' : Submodule ℂ (L2d 84)) (A' : Dom' →ₗ[ℂ] L2d 84),
          IsShiftInvert A' γ R → Dom' = Dom) := by sorry
