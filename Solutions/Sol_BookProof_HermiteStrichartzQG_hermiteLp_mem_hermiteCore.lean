-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.hermiteLp_mem_hermiteCore
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : hermiteLp n ∈ hermiteCore := Submodule.subset_span ⟨n, rfl⟩
