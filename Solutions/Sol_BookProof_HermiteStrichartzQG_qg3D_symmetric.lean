-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.qg3D_symmetric
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_symmetric
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) :
    SymmetricOn hermiteCore (qg3DHermiteHamiltonian xi xiY V) := hermiteCoreOp_symmetric _
