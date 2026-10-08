-- Generated from ChapterWignerSymmetry.lean — theorem BookProof.ChapterWignerSymmetry.wigner_symmetry_of_finiteDimensional
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry


open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}
variable {b : OrthonormalBasis ι ℂ E} {o : ι}

theorem BookProof.ChapterWignerSymmetry.wigner_symmetry_of_finiteDimensional {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [FiniteDimensional ℂ F] [Nontrivial F] {T : F → F}
    (hT : IsWignerSymmetry T) :
    (∃ U : F ≃ₗᵢ[ℂ] F, ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) ∨
    (∃ U : F → F, IsAntiunitary U ∧ ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) := by sorry
