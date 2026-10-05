import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Mathlib


/-!
# The resolvent family and the Yosida approximation of a non-negative self-adjoint relation

`BookProof.ChapterNonnegSquareRoot` produced, for a non-negative self-adjoint linear
relation `T` on a complex Hilbert space `F` and every `a > 0`, the everywhere-defined
bounded operator `R a = invCLMAt hT ha = (T + a)⁻¹` solving `a x + T x = h`, with
`‖R a h‖ ≤ ‖h‖ / a`.  This chapter develops that family into the standard resolvent
calculus and the Yosida approximation.

* **The first resolvent identity** `R a − R b = (b − a) R a R b` (`invCLMAt_sub`),
  and the commutation `R a R b = R b R a` (`invCLMAt_comm`).
* **Positivity.**  Each `R a` is self-adjoint (`isSelfAdjoint_invCLMAt`) and non-negative
  (`invCLMAt_nonneg`), and `a R a` is a positive contraction (`norm_smul_invCLMAt_le`,
  `smul_invCLMAt_le_one`).
* **`a R a → 1` strongly.**  On the domain, `a R a h − h = − R a k` for `(h, k) ∈ T`
  (`smul_invCLMAt_sub_of_mem`), so `‖a R a h − h‖ ≤ ‖k‖ / a`.  The domain of a
  single-valued non-negative self-adjoint relation is dense (`dense_domain`), whence
  `a R a h → h` for *every* `h` (`tendsto_smul_invCLMAt`, and the sequential form
  `tendsto_smul_resAt`).
* **The Yosida approximation** `T_a = a (1 − a R a) = a − a² R a` (`yosidaCLM`) is a
  bounded, self-adjoint, non-negative operator with `(a R a h, T_a h) ∈ T`
  (`yosidaCLM_mem`); on the domain `T_a h = a R a k` for `(h, k) ∈ T`
  (`yosidaCLM_of_mem`), so `‖T_a h‖ ≤ ‖k‖` (`norm_yosidaCLM_le_of_mem`) and
  `T_a h → k` (`tendsto_yosidaCLM`, `tendsto_yosidaAt`): the bounded operators `T_a`
  approximate `T` pointwise on its domain.  They increase with `a`
  (`yosidaCLM_sub`: `T_b − T_a = (b − a)(1 − a R a)(1 − b R b)`, whence `yosidaCLM_mono`)
  and stay below `T` on its domain (`re_inner_yosidaCLM_le`).

Everything is stated for linear relations, so no single-valuedness is assumed except
where the *strong* convergence statements need a dense domain.
-/

namespace BookProof.NonnegResolvent

open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

/-! ## The resolvent identity -/





/-! ## Positivity of the resolvent -/













/-! ## `a (T + a)⁻¹ → 1` strongly -/









/-! ## The Yosida approximation -/

/-- **The Yosida approximation `T_a = a (1 − a (T + a)⁻¹)`**, a bounded operator. -/
noncomputable def yosidaCLM (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) : F →L[ℂ] F :=
  (a : ℂ) • (1 - (a : ℂ) • invCLMAt hT ha)















/-! ## The Yosida approximation increases with `a` -/









/-! ## Sequential form -/

/-- The resolvent at `n + 1`, as a sequence of bounded operators. -/
noncomputable def resAt (hT : IsNonnegSelfAdjoint T) (n : ℕ) : F →L[ℂ] F :=
  invCLMAt hT (a := (n : ℝ) + 1) (by positivity)

/-- The Yosida approximation at `n + 1`, as a sequence of bounded operators. -/
noncomputable def yosidaAt (hT : IsNonnegSelfAdjoint T) (n : ℕ) : F →L[ℂ] F :=
  yosidaCLM hT (a := (n : ℝ) + 1) (by positivity)





end BookProof.NonnegResolvent
