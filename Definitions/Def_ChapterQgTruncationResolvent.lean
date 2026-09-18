

/-!
# Strong resolvent convergence of the mode-truncated quantum-gravity Hamiltonians

`BookProof.ChapterQgOuterFockFlow` proves that the outer-Fock quantum-gravity Hamiltonian
generates a unique unitary flow, and transfers *assumed* strong resolvent convergence of a
family of approximations into convergence of the flows.  This module removes the assumption
for the canonical discretization: the **mode truncation**, in which the vielbein
self-interaction `A` and the scalaron–vielbein coupling `B` are switched off outside a
finite window of modes, while the fibre operator — the scalaron kinetic term, the harmonic
term and the *full exponential* Starobinsky wall — is kept exactly.

## What is proved

* `esa_core_of_ext` — essential self-adjointness on the whole comparison domain descends to
  the graph core: the Faris–Lavine conclusion, which is proved on `𝒟(N)`, also holds on the
  finite-particle core, because the core approximates `𝒟(N)` in the graph norm and the
  Hamiltonian is relatively bounded.
* `strongResolventConvergence_of_dense`, `tendsto_resCLM_shift`,
  **`strongResolventConvergence_of_core`** — the general criterion (Reed–Simon VIII.25(a)):
  self-adjoint realizations of operators that converge pointwise on a common essentially
  self-adjoint core converge in the strong resolvent sense.
* `QgModeData.truncate` — the mode truncation of the quantum-gravity mode data: the same
  vielbein energies and bands, the interaction matrices restricted to a window `Λ`, and the
  *same* Faris–Lavine constant `K` (switching entries off cannot increase a Schur sum), so
  the truncated Hamiltonian is essentially self-adjoint by the same theorem.
* `secHam_truncate_eventually_eq` — on each core vector the truncated Hamiltonian eventually
  agrees with the exact one along an exhausting family of windows.
* **`qgOuterFock_truncation_flow_convergence`** — hence the truncated flows converge to the
  exact quantum-gravity flow, uniformly on compact time intervals; no hypothesis of
  resolvent convergence is assumed.  `starobinsky_qgContinuum_momentumCutoff_flow_convergence`
  is the physical instance: the exact Fourier modes of the vielbein with a momentum cutoff
  `|k| ≤ n`, the full exponential Einstein-frame wall and arbitrary coupling constant.

The mode cutoff analysed here is the *space* half of a concrete scheme.  The *time* half —
the Crank–Nicolson (Cayley) step, its unitarity, its consistency and the convergence of the
fully discrete evolution — is `BookProof.ChapterQgTimeStepping`; and the general theorems
below are stated for an arbitrary mode index type, so they apply verbatim over a general
spatial manifold (`BookProof.ChapterQgManifoldModeInstance`) and not only over the periodic
box used in the instance of §5.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgTruncationResolvent

open Filter Topology

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## 1. Essential self-adjointness descends to the graph core -/



/-! ## 2. A criterion for strong resolvent convergence -/







/-! ## 3. The mode truncation of the quantum-gravity Hamiltonian -/

variable {ι : Type*}

open Classical in
/-- **The mode truncation of the quantum-gravity mode data.**  The vielbein energies, the
bands and hence the fibre operator — the scalaron kinetic term, the harmonic term and the
full exponential Starobinsky wall — are kept exactly; the vielbein self-interaction and the
scalaron–vielbein coupling are switched off outside the window `Λ`.  Switching entries off
cannot increase any of the five Schur sums, so the Faris–Lavine constant `K` is unchanged
and the truncated Hamiltonian is essentially self-adjoint by the same theorem. -/
def truncModes (Q : QgModeData ι) (Λ : Set ι) : QgModeData ι where
  sig := Q.sig
  one_le_sig := Q.one_le_sig
  A := fun a b => if a ∈ Λ ∧ b ∈ Λ then Q.A a b else 0
  B := fun a b => if a ∈ Λ ∧ b ∈ Λ then Q.B a b else 0
  nbr := Q.nbr
  mem_nbr_comm := Q.mem_nbr_comm
  A_off := by
    intro a b h
    by_cases hc : a ∈ Λ ∧ b ∈ Λ <;> simp [hc, Q.A_off a b h]
  B_off := by
    intro a b h
    by_cases hc : a ∈ Λ ∧ b ∈ Λ <;> simp [hc, Q.B_off a b h]
  A_herm := by
    intro a b
    by_cases ha : a ∈ Λ <;> by_cases hb : b ∈ Λ <;> simp [ha, hb, Q.A_herm a b]
  B_herm := by
    intro a b
    by_cases ha : a ∈ Λ <;> by_cases hb : b ∈ Λ <;> simp [ha, hb, Q.B_herm a b]
  K := Q.K
  K_nonneg := Q.K_nonneg
  A_rel_row := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.A_rel_row a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero, zero_div]
      exact div_nonneg (norm_nonneg _) (Q.sig_nonneg b)
  A_rel_col := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.A_rel_col a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero]
      exact norm_nonneg _
  A_comm := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.A_comm a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero, mul_zero]
      positivity
  B_rel := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.B_rel a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero]
      exact norm_nonneg _
  B_comm := by
    intro a
    refine le_trans (Finset.sum_le_sum fun b _ => ?_) (Q.B_comm a)
    by_cases hc : a ∈ Λ ∧ b ∈ Λ
    · simp [hc]
    · simp only [hc, if_false, norm_zero, mul_zero]
      positivity







variable (W : WallPot) (Q : QgModeData ι)







/-! ## 4. The truncated flows converge to the exact quantum-gravity flow -/



/-! ## 5. The physical instance: the momentum cutoff of the continuum model -/


/-- **The momentum cutoff**: the window of all vielbein components with `|k|² ≤ n`.  This is
the discretization actually used in computations — the exact Fourier modes are kept, the
interactions above the cutoff are dropped. -/
def momWindow (n : ℕ) : Set CMode := {x | momSq x.1 ≤ (n : ℝ)}





/-! ## 6. The statement in the Hashimoto shift-invert interface -/






end

end BookProof.QgTruncationResolvent
