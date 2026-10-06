import Definitions.Def_ChapterStoneGenerator
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib


/-!
# Chapter SirkTrotterKato — the unbounded half of §12 Gap 3 (Trotter–Kato)

`CONSOLIDATED_PLAN.md` §12.2 **Gap 3** asks for the transfer of generator
convergence to the *unitary group*: `e^{−itAₙ} → e^{−itA}` strongly, locally
uniformly in `t`.  `ChapterSirkGroupTransfer` settled the **bounded** half (norm
convergence of bounded generators, with an explicit rate).  This chapter settles
the **unbounded** half — the Trotter–Kato theorem itself — for the unbounded
self-adjoint operators of `ChapterStoneResolvent`, i.e. exactly the objects the
selection theorems of the project produce:

> if the resolvents `(Aₙ − i)⁻¹` converge strongly to `(A − i)⁻¹`, then
> `e^{−itAₙ} v → e^{−itA} v` for every `v`, uniformly for `t` in a bounded
> interval.

The proof is the classical Duhamel argument, formalized in four steps.

* `hasDerivAt_stoneU_const_sub` — the backwards flow `r ↦ e^{−i(t−r)A} z`
  differentiates to `+ i A` on the domain.
* `hasDerivAt_stoneU_const_sub_apply` — the **weak product rule**: the flow is
  only strongly continuous, so `r ↦ e^{−i(t−r)A} (y r)` cannot be differentiated
  by the ordinary product rule; it is differentiated here from the definition,
  for a curve `y` differentiable at the point and taking its value there in the
  domain.
* `resolvent_commutator_eq` — the algebraic heart, `Aₛ Rₛ − Rₛ A = (R − Rₛ)(A − i)`
  on `dom A`, where `R = (A − i)⁻¹` and `Rₛ = (Aₛ − i)⁻¹`.
* `hasDerivAt_duhamel` — the Duhamel derivative
  `d/dr [ e^{−i(t−r)Aₛ} Rₛ e^{−irA} χ ] = i e^{−i(t−r)Aₛ} (R − Rₛ) e^{−irA}(A − i)χ`,
  and `norm_res_stoneU_sub_stoneU_res_le` — the resulting mean-value estimate.

The convergence statements are `trotterKato_uniform_of_mem_range` (on the dense
set `R(dom A)`), `trotterKato_uniform_on_interval` and
`trotterKato_tendstoUniformlyOn` (**the headline: locally uniformly in `t`**) and
`trotterKato_tendsto` (strong convergence at a fixed time).  The auxiliary
`tendsto_uniformly_on_isCompact_of_tendsto` is the standard equi-Lipschitz upgrade
of pointwise convergence to uniform convergence on a compact set.

## Honest boundary

Strong resolvent convergence is *assumed* at the single point `i` of the
resolvent set, which is all the theorem needs; nothing here proves that the
Galerkin/Hashimoto compressions of a given physical Hamiltonian satisfy it — that
is the content of the per-system selection theorems, which the project proves
separately.  Together with those, this chapter closes the transfer step: the
flow of the selected generator is the limit of the approximating flows.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace

namespace BookProof.ChapterSirkTrotterKato

open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-! ## 1. Differentiating the backwards flow -/







/-! ## 2. The Duhamel derivative -/









/-! ## 3. Pointwise convergence upgraded on compact sets -/



/-! ## 4. Trotter–Kato -/

variable (T : UnboundedSelfAdjoint H) (S : ℕ → UnboundedSelfAdjoint H)

/-- Strong convergence of the resolvents at the point `i` of the resolvent set. -/
def StrongResolventConvergence : Prop :=
  ∀ y : H, Tendsto (fun n => (S n).resCLM 1 y) atTop (𝓝 (T.resCLM 1 y))

/-- The resolvent difference, as a bounded operator. -/
def resDiff (n : ℕ) : H →L[ℂ] H := T.resCLM 1 - (S n).resCLM 1

















end BookProof.ChapterSirkTrotterKato
