-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qgCCR_tetrad
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_idxE_injective
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgCCR
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}

set_option maxHeartbeats 1000000 in
namespace BookProof.QuantumGravity3DGauge

open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

/-! ## F.1 — the singular Hamiltonian density and the densitized form -/

/-- The manuscript's 3D gravity Hamiltonian density,
`ℋ = (1/(16 e)) 𝒮² − (1/(24 e)) 𝒫²`, with the tetrad determinant `e = det e_i^a` in the
denominator: it is *not* defined where the tetrad degenerates. -/
def qg3DDensity (e s p : ℝ) : ℝ :=
  **The gravity canonical commutation relations on the core** (F.3):
  `[x_j, π_k] = i δ_{jk}`. -/
  theorem qgCCR (Φ : CoreRep 84 D) (j k : Fin 84) (x : D) :
      qgCoord Φ j (qgMom Φ k x) - qgMom Φ k (qgCoord Φ j x)
        = (if j = k then Complex.I else 0) • x := by
    exact coreRep_commutator Φ (mulOp (X j
