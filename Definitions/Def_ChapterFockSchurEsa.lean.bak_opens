import Definitions.Def_ChapterCoreBoundsEsa
import Mathlib

import Mathlib
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterStoneResolvent

/-!
# `dΓ(A)` for a Schur-class one-particle matrix: the number bound and essential
# self-adjointness on the finite-occupation core

`BookProof.ChapterFockDifferingBasesEsa` proves essential self-adjointness of a second
quantized Hamiltonian under the **unweighted `ℓ¹` gate** `∑ₖ ‖gₖ‖ < ∞` on its matrix
elements — a genuine restriction: a one-particle operator as simple as the
nearest-neighbour hopping `A_{jk} = 1` for `|j − k| = 1` has infinitely many entries of
modulus one and is not covered.

The gate that the physics actually asks for is the **Schur bound**

```text
∀ k, ∑_j |⟪e_j, A e_k⟫| ≤ K,
```

the classical criterion for boundedness of the one-particle operator `A`.  This module
proves that under that gate alone the second quantization `dΓ(A)` of
`BookProof.ChapterFockSecondQuantization` obeys the **number bound**

```text
‖dΓ(A) u‖ ≤ K ‖𝒩 u‖
```

on the finite-occupation core, that it **conserves the particle number** exactly, and
that it is therefore essentially self-adjoint there — with no diagonalizing basis and no
summability of the entries.

## What is proved

* `ndeg`, `numSym`, `InSector` — the particle number of a configuration, the comparison
  symbol `σ(α) = |α| + 1` and the sectors of the Fock space.
* `annA_inSector`, `creA_inSector`, `dGamma_inSector` — the ladder operators shift the
  sector by one, so `dΓ(A)` **preserves** it: second quantization conserves the particle
  number.
* `sum_normSq_annA` — `∑ₖ ‖a_k u‖² = ⟪u, 𝒩u⟫`, the identity behind the number bound.
* `schur_test` — the elementary (finite) Schur test `∑_{k,j} |A_{kj}| x_k y_j ≤ K‖x‖‖y‖`.
* **`norm_dGamma_le_of_sector`** — on the `n`-particle sector, `‖dΓ(A)u‖ ≤ K n ‖u‖`.
* **`norm_dGamma_le`** — hence `‖dΓ(A)u‖ ≤ K‖𝒩u‖` on the whole core, by orthogonality of
  the sectors.
* **`dGamma_essentiallySelfAdjointOn_core`** — the headline: for a Hermitian
  column-finite matrix with a Schur bound, `dΓ(A)` is essentially self-adjoint on the
  finite-occupation core, through
  `BookProof.CoreBounds.essentiallySelfAdjointOn_finiteModes_of_core_bounds_comm`.
* `dGamma_stone_flow`, `dGamma_positiveExtension_eq_closure` — the unique self-adjoint
  realization, its unitary group (Stone), and — for a positive matrix — the identification
  of the Friedrichs extension with the closure.
* `hopCol`, `isHermCol_hopCol`, `schurBound_hopCol`, `hopCol_not_summable`,
  **`hop_essentiallySelfAdjointOn_core`** — non-vacuity: the nearest-neighbour hopping
  matrix satisfies the Schur gate with `K = 2` while its entries are *not* summable, so
  the statement is strictly outside the `ℓ¹` gate of `ChapterFockDifferingBasesEsa`.

## Honest boundary

The one-particle matrix must be **column-finite** (each `A e_k` a finite combination of
basis states) — that is what makes `dΓ(A)` map the finite-occupation core into itself —
and Hermitian, and it must satisfy the Schur bound, which forces `A` itself to be
*bounded*.  Nothing here covers an unbounded one-particle operator: for those the number
operator is not a comparison operator and `dΓ` needs a different gate.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.FockSchur

open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

/-! ## 1. Particle number and sectors -/

/-- The **particle number** `|α| = ∑ᵢ αᵢ` of a configuration. -/
def ndeg (α : Conf) : ℕ := α.sum fun _ n => n

/-- The comparison symbol `σ(α) = |α| + 1`: the number operator plus one. -/
def numSym (α : Conf) : ℝ := (ndeg α : ℝ) + 1













/-- A state of the **`n`-particle sector**: every configuration it excites has `n`
quanta. -/
def InSector (n : ℕ) (u : FockAlg) : Prop := ∀ α ∈ u.support, ndeg α = n



















/-! ## 2. Norms of finitely supported states -/













/-! ## 3. The Schur test -/

/-- The **Schur gate**: the columns of the one-particle matrix are uniformly summable. -/
def SchurBound (col : ℕ → (ℕ →₀ ℂ)) (K : ℝ) : Prop :=
  ∀ k, ∑ j ∈ (col k).support, ‖(col k) j‖ ≤ K





/-! ## 4. The number bound -/

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}



/-! ## 5. Sector decomposition and the number bound on the core -/

/-- The part of a state in the `n`-particle sector. -/
def sectorPart (n : ℕ) (u : FockAlg) : FockAlg := u.filter fun α => ndeg α = n











/-! ## 6. Essential self-adjointness on the finite-occupation core -/

/-- The comparison operator `𝒩 + 1` applied to a finitely supported state. -/
def numWeight (u : FockAlg) : FockAlg :=
  Finsupp.onFinset u.support (fun α => (numSym α : ℂ) * u α) (by
    intro α hα
    by_contra hc
    have hz : u α = 0 := Finsupp.notMem_support_iff.mp hc
    simp only [hz, mul_zero, ne_eq, not_true_eq_false] at hα)











/-! ## 7. Non-vacuity: nearest-neighbour hopping -/

/-- The **nearest-neighbour hopping** matrix `A_{jk} = 1` for `|j − k| = 1`, presented by
its columns. -/
def hopCol (k : ℕ) : ℕ →₀ ℂ :=
  if k = 0 then Finsupp.single 1 (1 : ℂ)
  else Finsupp.single (k + 1) (1 : ℂ) + Finsupp.single (k - 1) (1 : ℂ)













/-! ## 8. The unique self-adjoint realization and its unitary group -/







end

end BookProof.FockSchur
