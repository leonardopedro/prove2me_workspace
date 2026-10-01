-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.mulHamiltonian_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.mulHamiltonian_deficiencyTrivialAt (lam : ℕ → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (mulSymbolDomain lam) (mulHamiltonian lam) z := by sorry
