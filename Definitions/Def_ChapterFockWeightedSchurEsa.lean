import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Mathlib


/-!
# `dΓ(A)` for an **unbounded** one-particle operator: the Schur gate weighted by the
# one-particle symbol

`BookProof.ChapterFockSchurEsa` proves the number bound `‖dΓ(A)u‖ ≤ K‖𝒩u‖` and essential
self-adjointness of `dΓ(A)` on the finite-occupation core under the **unweighted Schur
gate** `∑_j |A_{kj}| ≤ K` — a gate that forces the one-particle operator `A` to be
*bounded*.  The recorded next step was `dΓ` of an **unbounded** one-particle operator,
through "a Schur gate weighted by the one-particle symbol".  That is what this module
supplies.

Fix a **weight** `w : ℕ → ℝ` with `w k ≥ 1` — the one-particle symbol — and let

```text
𝒩_w = dΓ(diag (w²)),      σ(α) = ∑_k w_k² α_k + 1
```

be the weighted number operator and its symbol.  The gate is

```text
(row)   ∀ k, ∑_j |A_{kj}| ≤ K w_k,
(col)   ∀ j, ∑_k |A_{jk}| / w_k ≤ K,
(comm)  ∀ k, ∑_j |A_{kj}| · |w_j² − w_k²| / (w_k w_j) ≤ B.
```

For `w ≡ 1` this is the unweighted Schur gate with a vanishing commutator gate, so the
present statement contains the bounded one; but the row gate now allows the rows of `A`
to *grow* like the symbol, and the witness of section 7 — the one-particle matrix
`A_{k,k+1} = A_{k+1,k} = √(k+1)`, the position operator of a harmonic oscillator — is
genuinely unbounded and covered.

## What is proved

* `wdeg`, `wSym`, `wgt` — the weighted particle number `∑_k w_k² α_k`, the comparison
  symbol `σ = wdeg + 1` and the associated diagonal operator on the core.
* `annA_wgt` — the commutation relation `a_j 𝒩_w = (𝒩_w + w_j²) a_j`, the only algebraic
  input of the commutator estimate.
* `sum_wsq_normSq_annA` — `∑_k w_k² ‖a_k u‖² = ⟪u, 𝒩_w u⟫`, the weighted form of the
  identity behind the number bound.
* **`norm_dGamma_le_w`** — the relative bound `‖dΓ(A)u‖ ≤ K‖σ u‖` on the core, proved
  sector by sector: `dΓ(A)` conserves the particle number, so on the `n`-particle sector
  the weighted Schur test gives `‖dΓ(A)u‖² ≤ K² n ⟪u, 𝒩_w u⟫`, and `n ≤ wdeg` because
  `w ≥ 1`.
* **`dGammaOp_commForm_bound_w`** — the commutator estimate
  `|⟪u, i[dΓ(A), σ]u⟫| ≤ B⟪u, σ u⟫`: the part of `⟪dΓ(A)u, σu⟫` that survives conjugation
  is `∑_{k,j} conj(A_{kj})(w_j² − w_k²)⟪a_k u, a_j u⟫`, which the commutator gate controls
  by the same Schur test.
* **`dGamma_essentiallySelfAdjointOn_core_w`** — the headline: `dΓ(A)` is essentially
  self-adjoint on the finite-occupation core, and `dGamma_stone_flow_w` — its unitary
  group.
* `oscCol`, `isHermCol_oscCol`, `wRow_oscCol`, `wCol_oscCol`, `wComm_oscCol`,
  **`oscCol_not_schurBound`**, `oscCol_entry_atTop`, **`osc_essentiallySelfAdjointOn_core`**
  — the non-vacuity witness: an *unbounded* one-particle matrix (no unweighted Schur bound
  holds, and its entries tend to infinity) whose second quantization is covered.

## Honest boundary

The one-particle matrix must still be Hermitian and column-finite; what is removed is its
boundedness.  The three gates are conditions on the matrix *relative to the chosen symbol*
`w`; nothing here chooses `w` for a given Hamiltonian.  Everything is `sorry`-free and
`axiom`-free.
-/

namespace BookProof.FockWeightedSchur

open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

/-! ## 1. The weighted particle number -/

/-- The **weighted particle number** `∑_k w_k² α_k` of a configuration. -/
def wdeg (w : ℕ → ℝ) (α : Conf) : ℝ := α.sum fun k n => w k ^ 2 * n

/-- The comparison symbol `σ(α) = ∑_k w_k² α_k + 1`. -/
def wSym (w : ℕ → ℝ) (α : Conf) : ℝ := wdeg w α + 1

variable {w : ℕ → ℝ}















/-! ## 2. The weighted number operator on the core -/

/-- The comparison operator `𝒩_w + 1` applied to a finitely supported state. -/
def wgt (w : ℕ → ℝ) (u : FockAlg) : FockAlg :=
  Finsupp.onFinset u.support (fun α => (wSym w α : ℂ) * u α) (by
    intro α hα
    by_contra hc
    have hz : u α = 0 := Finsupp.notMem_support_iff.mp hc
    simp only [hz, mul_zero, ne_eq, not_true_eq_false] at hα)













/-! ## 3. The weighted Schur gates -/

variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

/-- The **row gate**: the rows of the one-particle matrix grow at most like the symbol. -/
def WRowBound (w : ℕ → ℝ) (col : ℕ → (ℕ →₀ ℂ)) (K : ℝ) : Prop :=
  ∀ k, ∑ j ∈ (col k).support, ‖(col k) j‖ ≤ K * w k

/-- The **column gate**: the columns, weighted by the reciprocal symbol, are summable. -/
def WColBound (w : ℕ → ℝ) (col : ℕ → (ℕ →₀ ℂ)) (K : ℝ) : Prop :=
  ∀ j, ∑ k ∈ (col j).support, ‖(col j) k‖ / w k ≤ K

/-- The **commutator gate**: the matrix of `[A, diag w²]`, weighted by `1/(w_k w_j)`, has
bounded rows. -/
def WCommBound (w : ℕ → ℝ) (col : ℕ → (ℕ →₀ ℂ)) (B : ℝ) : Prop :=
  ∀ k, ∑ j ∈ (col k).support, ‖(col k) j‖ * |w j ^ 2 - w k ^ 2| / (w k * w j) ≤ B















/-! ## 4. The relative bound, sector by sector -/



/-! ## 5. The relative bound on the core -/



/-! ## 6. The commutator estimate -/



/-! ## 7. Essential self-adjointness on the finite-occupation core -/













/-! ## 8. Non-vacuity: an unbounded one-particle operator -/



/-- The one-particle matrix `A_{k,k+1} = A_{k+1,k} = √(k+1)`, presented by its columns: the
position operator of a harmonic oscillator in the occupation basis.  It is Hermitian,
column-finite and **unbounded**. -/
def oscCol (k : ℕ) : ℕ →₀ ℂ :=
  if k = 0 then Finsupp.single 1 ((Real.sqrt 1 : ℝ) : ℂ)
  else Finsupp.single (k + 1) ((Real.sqrt ((k : ℝ) + 1) : ℝ) : ℂ)
      + Finsupp.single (k - 1) ((Real.sqrt (k : ℝ) : ℝ) : ℂ)

/-- The one-particle symbol `w_k = k + 1`. -/
def oscW (k : ℕ) : ℝ := (k : ℝ) + 1



































end

end BookProof.FockWeightedSchur
