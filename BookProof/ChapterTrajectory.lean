import Mathlib
import BookProof.ChapterDoubleSlit

/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system"
— §"Reconstruction of the trajectory" (post-selection / conditional probability)

Source: `book.tex`, chapter *"Reconstructing the classical trajectory of any
isolated quantum system"*, §*"Reconstruction of the trajectory"*
(`book.tex` line ~3044).

The book argues that although only the *final* time of a quantum trajectory can
be measured directly, *post-selection* — "using probabilities conditional on the
final state and the same quantum time-evolution" — lets us "repeat the experiment
in the same conditions and predict the results of a measurement at another time
between the initial and final times", so that the trajectory can be
reconstructed at intermediate instants.

We formalize the three-instant (initial → intermediate → final) *collapsed* Born
process on a finite phase space `Fin n`.  A unit initial wave-function `Ψ` is
evolved by a unitary `U` to the intermediate time, where a measurement in the
standard basis produces outcome `a` with the Born probability
`midProb = |(U Ψ)_a|²` and collapses the state to `e_a`; the collapsed state is
then evolved by a unitary `V` to the final time, where outcome `f` occurs with
probability `transProb = |V_{f a}|²`.

* `jointProb U V Ψ f a = midProb · transProb` is the joint law of
  (intermediate `a`, final `f`).
* `finalProb U V Ψ f = ∑ₐ jointProb` is the marginal final law.
* `condProb U V Ψ f a = jointProb / finalProb` is the **post-selected**
  (conditional on the final outcome `f`) law of the intermediate outcome — the
  Aharonov–Bergmann–Lebowitz / two-state reconstruction formula.

Main results:
* `finalProb_total` — the collapsed process is a genuine probability law:
  `∑_f finalProb = 1` (uses unitarity of `U`, `V` and `‖Ψ‖ = 1`).
* `jointProb_sum_final_eq_midProb` — summing the post-selected joint law over all
  final outcomes recovers the intermediate Born distribution (consistency of the
  reconstruction: the intermediate statistics do not depend on which final
  outcome one post-selects on).
* `condProb_sum` — for any realizable final outcome the post-selected
  intermediate law is a probability distribution (`∑ₐ condProb = 1`).

Concrete double-slit capstone (reusing `ChapterDoubleSlit`'s Hadamard `H`):
* `dslit_finalProb` / `dslit_condProb` — with `U = V = H` and `Ψ = (1,0)` the
  collapsed final law is uniform `1/2` and post-selecting on any final outcome
  reconstructs the uniform `1/2` intermediate law;
* `dslit_coherentFinal` — the *coherent* final law (no intermediate measurement,
  `|(V U Ψ)_f|²`) is instead `(1, 0)`;
* `dslit_interference` — the two differ (`finalProb = 1/2 ≠ 1 = coherentFinal`):
  the "self-interference mystery", i.e. why the reconstructed (post-selected)
  picture is *not* what coherent evolution gives.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators Matrix

namespace BookProof.ChapterTrajectory

variable {n : ℕ}

/-- Intermediate Born probability of outcome `a`: `|(U Ψ)_a|²`. -/
noncomputable def midProb (U : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (a : Fin n) : ℝ := ‖(U *ᵥ psi) a‖ ^ 2

/-- Transition probability from intermediate outcome `a` to final outcome `f`
after the collapse: `|V_{f a}|²`. -/
noncomputable def transProb (V : Matrix (Fin n) (Fin n) ℂ) (f a : Fin n) : ℝ :=
  ‖V f a‖ ^ 2

/-- Joint probability of (intermediate `a`, final `f`) in the collapsed
three-instant process. -/
noncomputable def jointProb (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f a : Fin n) : ℝ := midProb U psi a * transProb V f a

/-- Marginal probability of the final outcome `f`. -/
noncomputable def finalProb (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f : Fin n) : ℝ := ∑ a, jointProb U V psi f a

/-- Post-selected (conditional on final outcome `f`) probability of the
intermediate outcome `a` — the ABL / two-state reconstruction formula. -/
noncomputable def condProb (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f a : Fin n) : ℝ := jointProb U V psi f a / finalProb U V psi f

/-- The *coherent* final Born probability, with **no** intermediate measurement:
`|(V U Ψ)_f|²`. -/
noncomputable def coherentFinal (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f : Fin n) : ℝ := ‖((V * U) *ᵥ psi) f‖ ^ 2

/-! ## Nonnegativity -/

theorem midProb_nonneg (U : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (a : Fin n) : 0 ≤ midProb U psi a := by
  unfold midProb; positivity

theorem transProb_nonneg (V : Matrix (Fin n) (Fin n) ℂ) (f a : Fin n) :
    0 ≤ transProb V f a := by
  unfold transProb; positivity

theorem jointProb_nonneg (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f a : Fin n) : 0 ≤ jointProb U V psi f a :=
  mul_nonneg (midProb_nonneg _ _ _) (transProb_nonneg _ _ _)

theorem finalProb_nonneg (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f : Fin n) : 0 ≤ finalProb U V psi f :=
  Finset.sum_nonneg fun _ _ => jointProb_nonneg _ _ _ _ _

theorem condProb_nonneg (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f a : Fin n) : 0 ≤ condProb U V psi f a :=
  div_nonneg (jointProb_nonneg _ _ _ _ _) (finalProb_nonneg _ _ _ _)

/-! ## Reconstruction consistency and total mass -/

/-- Columns of a unitary matrix have unit `ℓ²` norm: `∑_f |V_{f a}|² = 1`. -/
theorem transProb_sum (V : Matrix (Fin n) (Fin n) ℂ) (hV : Vᴴ * V = 1)
    (a : Fin n) : ∑ f, transProb V f a = 1 := by
  unfold transProb; simp [ ← Matrix.ext_iff ] at *;
  simp_all [ Matrix.mul_apply, Complex.normSq, Complex.sq_norm ];
  simp_all [ Complex.ext_iff, Matrix.one_apply ]

/-- **Reconstruction consistency.**  Summing the post-selected joint law over all
final outcomes recovers the intermediate Born distribution: the intermediate
statistics one reconstructs do not depend on the final outcome chosen for
post-selection. -/
theorem jointProb_sum_final_eq_midProb (U V : Matrix (Fin n) (Fin n) ℂ)
    (psi : Fin n → ℂ) (hV : Vᴴ * V = 1) (a : Fin n) :
    ∑ f, jointProb U V psi f a = midProb U psi a := by
  convert congr_arg (fun x : ℝ => midProb U psi a * x) (transProb_sum V hV a) using 1
  · unfold jointProb; rw [Finset.mul_sum]
  · ring

/-- A unitary preserves the `ℓ²` mass of `Ψ`: `∑_a |(U Ψ)_a|² = ∑_a |Ψ_a|²`. -/
theorem midProb_sum (U : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (hU : Uᴴ * U = 1) : ∑ a, midProb U psi a = ∑ a, ‖psi a‖ ^ 2 := by
  have h_unitary : ∀ (x : Fin n → ℂ), ∑ a, ‖(U *ᵥ x) a‖ ^ 2 = ∑ a, ‖x a‖ ^ 2 := by
    intro x
    have h_sum : ∑ a, (U *ᵥ x) a * starRingEnd ℂ ((U *ᵥ x) a)
        = ∑ a, x a * starRingEnd ℂ (x a) := by
      have h_step : ∑ a, (U *ᵥ x) a * starRingEnd ℂ ((U *ᵥ x) a)
          = ∑ a, (starRingEnd ℂ (x a)) * (Uᴴ *ᵥ (U *ᵥ x)) a := by
        simp only [Matrix.mulVec, dotProduct, map_sum, map_mul, Finset.mul_sum, mul_comm,
          mul_assoc, Matrix.conjTranspose_apply, RCLike.star_def, mul_left_comm]
        exact Finset.sum_comm.trans (Finset.sum_congr rfl fun _ _ =>
          Finset.sum_congr rfl fun _ _ =>
            Finset.sum_congr rfl fun _ _ => by ring)
      simp_all [mul_comm]
    convert congr_arg Complex.re h_sum using 1 <;>
      norm_num [Complex.normSq, Complex.sq_norm]
  exact h_unitary psi

/-- **The collapsed three-instant process is a genuine probability law.**  If
`U`, `V` are unitary and `Ψ` is a unit vector, the final marginal sums to `1`. -/
theorem finalProb_total (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (hU : Uᴴ * U = 1) (hV : Vᴴ * V = 1) (hpsi : ∑ a, ‖psi a‖ ^ 2 = 1) :
    ∑ f, finalProb U V psi f = 1 := by
  unfold finalProb
  rw [← hpsi, Finset.sum_comm]
  rw [← midProb_sum U psi hU,
    Finset.sum_congr rfl fun _ _ => jointProb_sum_final_eq_midProb U V psi hV _]

/-- **Post-selected law is a probability distribution.**  For any realizable
final outcome `f` (`finalProb ≠ 0`), the reconstructed intermediate law sums to
`1`. -/
theorem condProb_sum (U V : Matrix (Fin n) (Fin n) ℂ) (psi : Fin n → ℂ)
    (f : Fin n) (hf : finalProb U V psi f ≠ 0) :
    ∑ a, condProb U V psi f a = 1 := by
  unfold condProb
  rw [← Finset.sum_div]
  exact div_self hf

/-! ## Double-slit capstone (reusing `ChapterDoubleSlit`'s Hadamard `H`) -/

open BookProof.ChapterDoubleSlit

/-- Every Hadamard entry has squared modulus `1/2`. -/
theorem transProb_H (f a : Fin 2) : transProb H f a = 1 / 2 := by
  fin_cases f <;> fin_cases a <;> simp [transProb, H]

/-- Intermediate Born distribution for the double slit is uniform `1/2`. -/
theorem midProb_H (a : Fin 2) : midProb H psi0 a = 1 / 2 := by
  simpa [midProb, bornProb] using BookProof.ChapterDoubleSlit.slit_closed_born a

/-- **Collapsed** final law of the double slit is uniform `1/2`. -/
theorem dslit_finalProb (f : Fin 2) : finalProb H H psi0 f = 1 / 2 := by
  unfold finalProb jointProb
  fin_cases f <;> norm_num [midProb_H, transProb_H]

/-- **Coherent** final law of the double slit (no intermediate measurement) is
certain `(1, 0)`. -/
theorem dslit_coherentFinal :
    coherentFinal H H psi0 0 = 1 ∧ coherentFinal H H psi0 1 = 0 := by
  have h := slit_open_born
  unfold coherentFinal
  rw [← Matrix.mulVec_mulVec]
  exact h

/-- Post-selecting on **any** final outcome reconstructs the uniform `1/2`
intermediate law. -/
theorem dslit_condProb (f a : Fin 2) : condProb H H psi0 f a = 1 / 2 := by
  fin_cases f <;> fin_cases a <;>
    simp [condProb, jointProb, midProb_H, transProb_H, dslit_finalProb]

/-- **The self-interference "mystery".**  The reconstructed (post-selected,
collapsed) final law differs from the coherent final law: `1/2 ≠ 1`. -/
theorem dslit_interference :
    finalProb H H psi0 0 ≠ coherentFinal H H psi0 0 := by
  rw [dslit_finalProb, (dslit_coherentFinal).1]; norm_num

end BookProof.ChapterTrajectory
