import Mathlib

/-!
# Chapter F5 — Quantum Flow Matching: symmetric generators & commuting flows (roadmap N14, §0 S7)

This file continues the *Quantum Flow Matching* (QFM) formalization
(source `RiemannProof/QFM.tex`; reference implementation `../unfer/qfm/`) begun in
`ChapterF3.lean` / `ChapterF4.lean`.  It follows §0 S7 of the roadmap (the
Mehler/Kopperman generative flow).

## Deliverables (this file)

* **F2.1 — continuity-Hamiltonian Hermiticity, algebraic core** (§4, eq. 4.2):
  the *symmetrized product* (anticommutator) `K ∘ V + V ∘ K` of two symmetric
  operators is symmetric, even when `K` and `V` do **not** commute
  (`anticommutator_isSymmetric`).  This is the structural reason the symmetrized
  continuity Hamiltonian `H = ½(p̂·v(x̂) + v(x̂)·p̂)` is Hermitian; the concrete
  `p̂ = −i ∂`, `x̂` symmetry is the standard integration-by-parts fact, whose
  algebraic payoff is captured here.
* **F2.2 — conservative commutator form, algebraic core** (§4, eqs. 4.4–4.6):
  `i · [K, V] = i · (K ∘ V − V ∘ K)` is symmetric whenever `K` and `V` are
  (`i_commutator_isSymmetric`).  This is exactly the reason the conservative
  Hamiltonian `H^c = i • [K, V(x̂)]` (with `K = ½ p̂·p̂`) is Hermitian.
* **F2.5 — exact commutativity and time-averaging** (§5.4): a pairwise-commuting
  family of channel generators has a fully factorizing time-ordered flow —
  `exp(−i t • ∑ⱼ Hⱼ) = ∏ⱼ exp(−i t • Hⱼ)` (`commuting_flow_two`,
  `commuting_flow_finset`).  Physically: disjoint packet supports ⇒
  `[ĥⱼ, ĥₖ] = 0` ⇒ `[H_t, H_{t'}] = 0`, so the Magnus/Dyson series truncates and
  the time-ordered flow equals `exp(−i • H̄)` with the time-averaged generator
  `H̄ = ∫₀¹ H_t dt` — here the constant-in-time commuting case, whose factorized
  product is the mathematical content.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.  Cites `../unfer` crates
`qfm/src/potential.rs` (F2.1/F2.2), `qfm_hamiltonian` (F2.5).
-/

open scoped BigOperators
open NormedSpace

namespace BookProof.ChapterF5

noncomputable section

/-! ## F2.1 — the symmetrized product (anticommutator) is symmetric -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- **F2.1** (algebraic core of continuity-Hamiltonian Hermiticity, §4 eq. 4.2):
the symmetrized product `K ∘ V + V ∘ K` of two symmetric complex-linear
operators is symmetric — *without any commutation hypothesis*.  This is the
reason `H = ½(p̂·v(x̂) + v(x̂)·p̂)` is Hermitian even though `p̂` and `v(x̂)` do
not commute (`../unfer` `qfm/src/potential.rs`). -/
theorem anticommutator_isSymmetric {K V : E →ₗ[ℂ] E}
    (hK : K.IsSymmetric) (hV : V.IsSymmetric) :
    (K ∘ₗ V + V ∘ₗ K).IsSymmetric := by
  intro x y
  simp only [LinearMap.add_apply, LinearMap.comp_apply, inner_add_left, inner_add_right]
  rw [hK, hV, hV, hK, add_comm]

/-! ## F2.2 — `i` times the commutator of symmetric operators is symmetric -/

/-- **F2.2** (algebraic core of the conservative commutator form, §4 eqs. 4.4–4.6):
`i • [K, V] = i • (K ∘ V − V ∘ K)` is symmetric whenever `K` and `V` are.  The
commutator of two symmetric operators is skew-symmetric, and multiplying by the
imaginary unit `i` restores symmetry.  This is the reason the conservative
Hamiltonian `H^c = i • [K, V(x̂)]` (with `K = ½ p̂·p̂`) is Hermitian
(`../unfer` `qfm/src/potential.rs`). -/
theorem i_commutator_isSymmetric {K V : E →ₗ[ℂ] E}
    (hK : K.IsSymmetric) (hV : V.IsSymmetric) :
    ((Complex.I : ℂ) • (K ∘ₗ V - V ∘ₗ K)).IsSymmetric := by
  intro x y
  simp only [LinearMap.smul_apply, LinearMap.sub_apply, LinearMap.comp_apply,
    inner_smul_left, inner_smul_right, inner_sub_left, inner_sub_right]
  rw [hK, hV, hV, hK, Complex.conj_I]
  ring

/-! ## F2.5 — commuting channel generators have a factorizing time-ordered flow -/

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℚ 𝔸] [CompleteSpace 𝔸]
  [NormedAlgebra ℂ 𝔸]

/-- **F2.5** (two-channel factorization, §5.4): for two commuting channel
generators `A`, `B`, the joint flow at (complex) time `t` factorizes,
`exp(−i t • (A + B)) = exp(−i t • A) · exp(−i t • B)`.  Disjoint packet supports
force `[ĥⱼ, ĥₖ] = 0`, which is exactly the `Commute A B` hypothesis here. -/
theorem commuting_flow_two (t : ℂ) {A B : 𝔸} (h : Commute A B) :
    exp (-(t * Complex.I) • (A + B))
      = exp (-(t * Complex.I) • A) * exp (-(t * Complex.I) • B) := by
  rw [smul_add]
  exact exp_add_of_commute ((h.smul_left _).smul_right _)

/-- **F2.5** (finite-family factorization, §5.4): for a pairwise-commuting family
`H : ι → 𝔸` of channel generators, the time-ordered flow of the total generator
`∑ⱼ Hⱼ` at (complex) time `t` equals the (order-independent, since commuting)
product of the individual channel flows,
`exp(−i t • ∑ⱼ Hⱼ) = ∏ⱼ exp(−i t • Hⱼ)`.  This is the truncation of the
Magnus/Dyson series for a commuting family — the `../unfer` `qfm_hamiltonian`
time-averaging identity. -/
theorem commuting_flow_finset {ι : Type*} (s : Finset ι) (H : ι → 𝔸) (t : ℂ)
    (h : (↑s : Set ι).Pairwise (Function.onFun Commute H)) :
    exp (-(t * Complex.I) • ∑ i ∈ s, H i)
      = s.noncommProd (fun i => exp (-(t * Complex.I) • H i))
          (fun _ hi _ hj hij => (((h hi hj hij).smul_left _).smul_right _).exp) := by
  rw [Finset.smul_sum]
  exact exp_sum_of_commute s (fun i => -(t * Complex.I) • H i)
    (fun _ hi _ hj hij => ((h hi hj hij).smul_left _).smul_right _)

end

end BookProof.ChapterF5
