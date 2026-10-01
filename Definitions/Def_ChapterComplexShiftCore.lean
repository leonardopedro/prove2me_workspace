import Definitions.Def_ChapterFarisLavineCore
import Mathlib


/-!
# The non-real shift `γ − A` of a symmetric operator

The abstract core of `BookProof.ChapterHashimotoComplexShifts`: for a symmetric
operator `A` on a domain of a complex Hilbert space and a shift `γ` off the real
axis, `‖(γ − A)x‖ ≥ |Im γ| ‖x‖` (`norm_cshiftMap_ge`), so `γ − A` is injective
with closed range, and for a self-adjoint `A` it is bijective
(`cshiftMap_surjective`).

This material depends on `BookProof.ChapterFarisLavineCore` and Mathlib alone; it
is separated out so that the unbounded-operator chapters that need only the shift
bound do not have to build the whole SIRK/Hashimoto development.
-/

namespace BookProof.HashimotoShiftInvert

open BookProof.FarisLavine
open Filter Topology

/-! ## A self-adjoint operator is closed -/

section Closed

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}



end Closed

/-! ## Part 1 — the non-real shift bound -/

section CBound

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

/-- The shifted operator `γ I − A` on the domain of `A`, for a **complex** shift
`γ`.  This is the operator the Hashimoto/SIRK algorithm inverts. -/
noncomputable def cshiftMap (A : Dom →ₗ[ℂ] F) (γ : ℂ) : Dom →ₗ[ℂ] F :=
  γ • Dom.subtype - A







end CBound

/-! ## Part 2 — for a self-adjoint operator a non-real shift is a bijection -/

section CSurjective

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

/-- The range of `γ − A`, as a submodule. -/
noncomputable def cshiftRange (A : Dom →ₗ[ℂ] F) (γ : ℂ) : Submodule ℂ F :=
  LinearMap.range (cshiftMap A γ)







end CSurjective

end BookProof.HashimotoShiftInvert
