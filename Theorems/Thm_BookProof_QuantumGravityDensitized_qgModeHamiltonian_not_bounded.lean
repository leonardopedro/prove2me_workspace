-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.qgModeHamiltonian_not_bounded
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.qgModeHamiltonian_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : mulSymbolDomain (qgModeSymbol (fun k => (k : ℝ)) 0 0),
      ‖qgModeHamiltonian (fun k => (k : ℝ)) 0 0 f‖ ≤ C * ‖(f : L2Nat)‖ := by sorry
