import Definitions.Def_ChapterNonnegSemigroup
import Mathlib


/-!
# The generator of the contraction semigroup `e^{-tT}`

`BookProof.ChapterNonnegSemigroup` built, for a non-negative self-adjoint linear relation
`T` on a complex Hilbert space `F`, the contraction semigroup `e^{-tT}`
(`BookProof.NonnegSemigroup.semigroupS`) as the Yosida limit of the bounded semigroups
`e^{-tT_a}`, together with the semigroup law, self-adjointness, the contraction bound and
strong continuity at `0`.  This chapter supplies the three items that chapter left open:

* **Positivity.**  `e^{-tA} = (e^{-tA/2})²` is a positive operator for every self-adjoint
  `A` (`expNeg_nonneg`), and positivity passes to the limit: `0 ≤ e^{-tT}`
  (`semigroupS_nonneg`).
* **Strong continuity in `t`, not merely at `0`.**  The semigroup law turns the estimate at
  the origin into a *uniform* modulus of continuity along the whole orbit:
  `‖e^{-tT}x − e^{-sT}x‖ ≤ ‖e^{-(t-s)T}x − x‖` (`norm_semigroupS_sub_semigroupS_le`), hence
  `semigroupS_uniformly_continuous`.
* **The generator.**  `e^{-tT}` commutes with the resolvent (`semigroupS_invCLMAt_comm`),
  hence leaves the domain of `T` invariant and commutes with `T` on it:
  `(h, k) ∈ T → (e^{-tT}h, e^{-tT}k) ∈ T` (`semigroupS_mem_of_mem`).  The quantitative
  estimate `‖e^{-tT}h − h + t·k‖ ≤ t (2ε + t‖k''‖)` (`norm_semigroupS_sub_add_smul_le`),
  obtained from the bounded estimate `norm_expNeg_sub_add_smul_le` by the mean-value
  inequality along the approximations, gives the **differential equation** in difference
  quotient form: `t⁻¹ (e^{-tT}h − h) → −k` as `t ↓ 0`
  (`tendsto_semigroupS_difference_quotient`) and, at a general time,
  `u⁻¹ (e^{-(t+u)T}h − e^{-tT}h) → −e^{-tT}k` (`tendsto_semigroupS_difference_quotient_at`):
  `T` is the generator of its own semigroup.
* **Decay from a spectral lower bound.**  If `Re⟪h, k⟫ ≥ λ‖h‖²` on the graph of `T`, the
  Yosida approximations inherit the bound in the form `T_a ≥ aλ/(a + λ)` (`yosidaCLM_ge`),
  the bounded semigroups decay at that rate (`norm_expNeg_le_exp`, Gronwall on
  `s ↦ e^{2μs}‖e^{-sA}x‖²`), and in the limit `‖e^{-tT}x‖ ≤ e^{-λt}‖x‖`
  (`norm_semigroupS_le_exp`): a spectral gap becomes a decay rate.
-/

namespace BookProof.NonnegSemigroupGenerator

open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

noncomputable local instance ratNormedAlgebra'' : NormedAlgebra ℚ (F →L[ℂ] F) :=
  NormedAlgebra.restrictScalars ℚ ℂ (F →L[ℂ] F)

/-! ## Positivity of the semigroup -/



variable {T : Submodule ℂ (F × F)}



/-! ## Strong continuity in the time variable -/







/-! ## Commutation with the resolvent and invariance of the domain -/









/-! ## The generator -/









/-! ## Exponential decay from a spectral lower bound -/







end BookProof.NonnegSemigroupGenerator
