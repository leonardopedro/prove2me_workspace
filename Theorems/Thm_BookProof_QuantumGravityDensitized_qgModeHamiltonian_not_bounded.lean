-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.qgModeHamiltonian_not_bounded
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine
open BookProof.QuantumGravityDensitized



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.qgModeHamiltonian_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : mulSymbolDomain (qgModeSymbol (fun k => (k : ℝ)) 0 0),
      ‖qgModeHamiltonian (fun k => (k : ℝ)) 0 0 f‖ ≤ C * ‖(f : L2Nat)‖ := by sorry
