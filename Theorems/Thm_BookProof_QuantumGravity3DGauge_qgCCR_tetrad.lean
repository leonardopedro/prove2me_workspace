-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qgCCR_tetrad
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}

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
def qg3DDensity (e s p : ℝ) : ℝ := by sorry
