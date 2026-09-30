import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib

import Mathlib

/-!
# A Carleman criterion on simplex shells: hops which couple distinct modes

`BookProof.ChapterHermiteCarlemanEsa` and `BookProof.ChapterCarlemanTwoStep` run the
Carleman flux argument on **cubes** `{α : ∀ i, αᵢ ≤ N}`, for hops which move a *single*
excitation number: `α ↦ α ± eᵢ` and `α ↦ α ± 2eᵢ`.  That is exactly the ladder structure
of a quadratic Hamiltonian which does not couple distinct modes.

A general real quadratic Hamiltonian does couple them: `xᵢxⱼ`, `πᵢπⱼ` and `xᵢπⱼ` with
`i ≠ j` produce the hops `α ↦ α ± (eᵢ + eⱼ)` and `α ↦ α + eᵢ − eⱼ`.  On a cube the
bookkeeping of such hops is awkward — a hop leaves a cube through *two* faces at once,
and the mixed hop `α ↦ α + eᵢ − eⱼ` leaves it through one face while entering through
another.

This module reruns the argument on the **simplex shells** `{α : |α| ≤ N}`, where
`|α| = ∑ᵢ αᵢ` is the total degree.  The exhaustion is adapted to the grading by total
excitation number, and everything becomes uniform:

* a hop which *raises* the total degree by `k` (`α ↦ α + P` with `|P| = k`) leaks only
  through the shell `{N − k < |α| ≤ N}`, which meets at most `k` of the shells;
* a hop which *preserves* the total degree (`α ↦ α + eᵢ − eⱼ`) never leaves a shell, so
  it contributes **nothing at all** to the flux: the corresponding sum over a shell is
  real as soon as its amplitude matrix is Hermitian.

## What is proved

* `deg`, `simplexF`, `sInn`, `sBd` — the total degree, the simplex shells and their
  interiors and boundaries.
* `sum_simplex_hop_im` — **the abstract flux cancellation** for a hop `α ↦ α + P` of an
  arbitrary shift `P`: the interior contributions occur in conjugate pairs, so only the
  boundary shell contributes to the imaginary part.
* `sum_mterm_im` — **the degree-preserving hops carry no flux**: for a Hermitian
  amplitude matrix the total contribution of the hops `α ↦ α + eᵢ − eⱼ` over a shell is
  real.
* `LadderRecQ`, `flux_identityQ` — the recursion of a *general* quadratic ladder — one
  step, two steps, pair creation/annihilation and mode exchange — and its flux identity.
* `flux_bound_on`, `sBd_multiplicity`, `shifted_sBd_multiplicity` — the flux bound and
  the summability of the boundary mass (each index lies in at most `k` boundary shells).
* `ladderQ_eq_zero` — **the criterion.**  A square-summable family satisfying the general
  quadratic recursion, with a real diagonal, constant amplitudes and a Hermitian exchange
  matrix, at a point off the real axis, vanishes.  The Carleman divergence used is
  `∑ 1/(N+2) = ∞`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.CarlemanSimplex

open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

/-! ## 1. The simplex shells -/

/-- The total degree `|α| = ∑ᵢ αᵢ` of a multi-index. -/
def deg (a : Fin d →₀ ℕ) : ℕ := ∑ i, a i











/-- The simplex shell `{α : |α| ≤ N}` of multi-indices, as a finite set. -/
def simplexF (d N : ℕ) : Finset (Fin d →₀ ℕ) := (cube d N).filter (fun a => deg a ≤ N)



/-- The part of a shell which can still be raised by `k` degrees without leaving it. -/
def sInn (d N k : ℕ) : Finset (Fin d →₀ ℕ) := (simplexF d N).filter (fun a => deg a + k ≤ N)

/-- The `k`-thick boundary of a shell. -/
def sBd (d N k : ℕ) : Finset (Fin d →₀ ℕ) := (simplexF d N).filter (fun a => N < deg a + k)









/-! ## 2. The abstract flux cancellation for a raising hop -/

variable {u : (Fin d →₀ ℕ) → ℂ}

/-- The raising contribution of the hop `α ↦ α + P`. -/
def rtermP (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (rc : (Fin d →₀ ℕ) → ℝ) (P : Fin d →₀ ℕ)
    (a : Fin d →₀ ℕ) : ℂ :=
  (starRingEnd ℂ) w * ((rc a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a + P)

/-- The lowering contribution of the hop `α ↦ α − P`. -/
def ltermP (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (lc : (Fin d →₀ ℕ) → ℝ) (P : Fin d →₀ ℕ)
    (a : Fin d →₀ ℕ) : ℂ :=
  w * ((lc a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a - P)







/-! ## 3. The degree-preserving hops carry no flux -/

/-- The mode-exchange hop `α ↦ α − eⱼ + eᵢ`. -/
def shiftm (a : Fin d →₀ ℕ) (i j : Fin d) : Fin d →₀ ℕ :=
  a - Finsupp.single j 1 + Finsupp.single i 1

/-- The amplitude of the mode-exchange hop: `√(αⱼ(αᵢ+1))` for `i ≠ j`, and the number
`αᵢ` for `i = j`. -/
def rcm (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a j : ℝ)) * Real.sqrt ((((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)

/-- The contribution of the mode-exchange hop `(i, j)`. -/
def mterm (u : (Fin d →₀ ℕ) → ℂ) (M : Fin d → Fin d → ℂ) (a : Fin d →₀ ℕ) (i j : Fin d) : ℂ :=
  M i j * ((rcm a i j : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (shiftm a i j)















/-! ## 4. The general quadratic recursion -/

/-- The shift of the pair hop `(i, j)`: `eᵢ + eⱼ`. -/
def pvec (i j : Fin d) : Fin d →₀ ℕ := Finsupp.single i 1 + Finsupp.single j 1



/-- The raising amplitude of the pair hop: `√((αᵢ+1)(αⱼ+1))` for `i ≠ j`, and
`√((αᵢ+1)(αᵢ+2))` for `i = j`. -/
def rcp (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a j : ℝ) + 1) * Real.sqrt ((((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)

/-- The lowering amplitude of the pair hop: `√(αᵢαⱼ)` for `i ≠ j`, and `√(αᵢ(αᵢ−1))` for
`i = j`. -/
def lcp (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a i : ℝ)) * Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ))







/-- **The general quadratic recursion**: a real diagonal `lam`, one-step amplitudes `w`,
pair creation/annihilation amplitudes `W`, and a mode-exchange matrix `M`. -/
def LadderRecQ (u : (Fin d →₀ ℕ) → ℂ) (lam : (Fin d →₀ ℕ) → ℝ) (w : Fin d → ℂ)
    (W M : Fin d → Fin d → ℂ) (z : ℂ) : Prop :=
  ∀ a : Fin d →₀ ℕ,
    ((lam a : ℝ) : ℂ) * u a
      + ∑ i, ((starRingEnd ℂ) (w i) * ((rc1 a i : ℝ) : ℂ) * u (a + Finsupp.single i 1)
            + w i * ((lc1 a i : ℝ) : ℂ) * u (a - Finsupp.single i 1))
      + ∑ i, ∑ j, ((starRingEnd ℂ) (W i j) * ((rcp a i j : ℝ) : ℂ) * u (a + pvec i j)
            + W i j * ((lcp a i j : ℝ) : ℂ) * u (a - pvec i j))
      + ∑ i, ∑ j, (M i j * ((rcm a i j : ℝ) : ℂ) * u (shiftm a i j))
      = z * u a

variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}





/-! ## 5. The flux bound and the boundary mass -/













/-! ## 6. The criterion -/



end

end BookProof.CarlemanSimplex
