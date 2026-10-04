import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterA4
import Mathlib


/-!
# The resolvent correspondence: `T ↦ (1 + T)⁻¹` is a bijection onto the positive contractions

`BookProof.ChapterPositiveSquareRootUnique` attaches to every non-negative self-adjoint
linear relation `T` on a complex Hilbert space `F` the everywhere-defined bounded
operator `invCLM hT = (1 + T)⁻¹`, and shows that it is a positive contraction
(`invCLM_nonneg`, `invCLM_le_one`) from which `T` is recovered (`rel_eq_of_invCLM_eq`).

This chapter closes the correspondence in the other direction: **every** positive
contraction `R` (`0 ≤ R ≤ 1`) is the resolvent of one, and only one, non-negative
self-adjoint linear relation, namely

`relOfCLM R = {(R y, y − R y) : y ∈ F}`,

formally `R⁻¹ − 1`.  So `T ↦ (1 + T)⁻¹` is a bijection

`{non-negative self-adjoint linear relations on F} ≃ {R : F →L[ℂ] F | 0 ≤ R ≤ 1}`,

with inverse `R ↦ relOfCLM R` (`relOfCLM_invCLM`, `invCLM_relOfCLM`,
`existsUnique_isNonnegSelfAdjoint_invCLM_eq`).  Under it, the operators — the
single-valued relations — correspond to the *injective* positive contractions
(`singleValued_relOfCLM_iff`), and the domain of `T` is the range of `R`
(`mem_domain_relOfCLM_iff`).

The proof of non-negativity is the identity `R (1 − R) = (R^{1/2}(1−R)^{1/2})²`
(`mul_one_sub_eq_midOp_sq`), which makes `⟪R y, y − R y⟫ = ‖R^{1/2}(1−R)^{1/2} y‖²`
manifestly non-negative.
-/

namespace BookProof.ResolventCorrespondence

open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

/-! ## The relation attached to a bounded operator -/




/-- **`R⁻¹ − 1` as a linear relation**: the set of pairs `(R y, y − R y)`. -/
noncomputable def relOfCLM (R : F →L[ℂ] F) : Submodule ℂ (F × F) :=
  LinearMap.range (R.toLinearMap.prod ((1 : F →L[ℂ] F) - R).toLinearMap)





/-! ## `relOfCLM R` is non-negative and self-adjoint -/















/-! ## The two constructions are mutually inverse -/







/-! ## Operators correspond to injective contractions -/





end BookProof.ResolventCorrespondence
