-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.strichartz_finiteSpeed_satisfiable
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFarisLavineCore
open BookProof.FarisLavine
open BookProof.QuantumGravityDensitized



open Filter Topology BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.QuantumGravityDensitized.strichartz_finiteSpeed_satisfiable (a b V : ℕ → ℝ) :
    EssentiallySelfAdjointOn (mulSymbolDomain (qgModeSymbol a b V)) (qgModeHamiltonian a b V) := by sorry
