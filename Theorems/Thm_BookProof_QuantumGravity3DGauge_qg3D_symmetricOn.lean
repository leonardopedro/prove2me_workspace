-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qg3D_symmetricOn
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

4 :=
  signedOp qgKappa (qgMom Φ) (torsionOps Φ)

theorem BookProof.QuantumGravity3DGauge.qg3D_symmetricOn (Φ : CoreRep 84 D) (x : D) :
    qg3DHamiltonian Φ x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j, ((qgKappa j : ℝ) : ℂ) • ((qgMom Φ j (qgMom Φ j x) : D) : L2d 84))
            + ∑ m, ((torsionOps Φ m (torsionOps Φ m x) : D) : L2d 84)) :=
  signedOp_apply qgKappa (qgMom Φ) (torsionOps Φ) x

/-- **F.5 — the gravity Hamiltonian is symmetric on the core**, for the physical
(hyper := by sorry
