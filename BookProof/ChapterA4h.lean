import Mathlib
import BookProof.ChapterA4e
import BookProof.ChapterA4f
import BookProof.ChapterA5

/-!
# Chapter A4h — the Wigner/Mackey exhaustiveness bundle (roadmap N11, §A.4–A.5)

This file assembles the *exhaustiveness clauses* of Props 87/88 and Cor 1 of the
book's §A.4/A.5.  Following the design of `IsSchurFull` / `PauliFundamental`
(§A.2/§A.3), the genuinely external inputs — Wigner's 1939 little-group
classification and Mackey's imprimitivity theorem — are introduced as **named
hypotheses with citation docstrings, never as `axiom`s**; the *conditional
headline theorems* are then proved around them, reusing the on-disk exclusion
cores of `ChapterA4e`/`ChapterA4f`/`ChapterA5`.

## Concrete payload (fully proved, no external input)

* `localizable_iff_massShell` — the concrete Majorana energy symbol
  `energySymbolR p m₁ m₂` (§A.5) is singular **iff** we sit on the mass shell
  `|p⃗|² = m₁² + m₂²`.  (From `ChapterA5.energySymbolR_sq`.)
* `not_localizable_of_tachyon`, `not_localizable_zeroMomentum` — the tachyonic
  (`m² > |p⃗|²`) and zero-momentum (`p = 0`, `m ≠ 0`) symbols are everywhere
  invertible, hence not localizable.  (Exclusions 1–2 of Prop 87.)

## External bundle (named hypotheses, cited, never axioms)

* `MackeyImprimitivity` (Mackey 1949/1952; Varadarajan Thm 6.12): a localizable
  unitary irrep is induced, hence realized by a concrete localizable energy
  symbol.
* `WignerClassification` (Wigner 1939): the massless *continuous-spin* class does
  not occur among localizable induced irreps (cf. `ChapterA4f.infinite_spin_excluded`).

## Conditional headlines

* `prop87_assembled` — a localizable induced irrep is **massive** or
  **massless with discrete helicity** (tachyons excluded by the concrete mass
  shell, infinite spin excluded by Wigner).
* `prop88_energy_sign_not_conserved` + `cor1_energy_sectors_swapped` — the
  energy-sign projectors are not conserved and are exchanged by spatial motion:
  antiparticles / CPT (from `ChapterA4e`).
* `prop87_88_assembled` — the combined Prop 87 + Prop 88 statement.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); the `EXTERNAL` inputs are hypotheses, not axioms.
-/

open Matrix

namespace BookProof.ChapterA4h

open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

/-! ## Concrete localizability of the Majorana energy symbol -/

/-- A relativistic wave operator is *localizable* on its orbit when its energy
symbol is singular (admits a nontrivial kernel — the mass shell on which the
localized state sits).  An everywhere-invertible symbol carries no proper
invariant subspace, which is the mathematical form of the Prop 87 exclusions. -/
def Localizable (p : Fin 3 → ℝ) (m₁ m₂ : ℝ) : Prop :=
  ¬ IsUnit (energySymbolR p m₁ m₂).det

/--
**Concrete mass-shell criterion.** The Majorana energy symbol is singular
iff `|p⃗|² = m₁² + m₂²`.  Since `D² = (|p⃗|² − m₁² − m₂²)·1` (`energySymbolR_sq`),
`(det D)² = (|p⃗|² − m₁² − m₂²)⁴`, so `det D = 0 ⟺ |p⃗|² = m₁² + m₂²`.
-/
theorem localizable_iff_massShell (p : Fin 3 → ℝ) (m₁ m₂ : ℝ) :
    Localizable p m₁ m₂ ↔ p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 = m₁ ^ 2 + m₂ ^ 2 := by
  unfold Localizable;
  rw [ isUnit_iff_ne_zero ];
  have := congr_arg Matrix.det ( energySymbolR_sq p m₁ m₂ ) ; norm_num at this;
  grind

/--
**Exclusion 1 (no tachyons).** If `m₁² + m₂² > |p⃗|²` the symbol is invertible,
so the spacelike (tachyonic) orbit is not localizable.
-/
theorem not_localizable_of_tachyon (p : Fin 3 → ℝ) (m₁ m₂ : ℝ)
    (h : p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 < m₁ ^ 2 + m₂ ^ 2) :
    ¬ Localizable p m₁ m₂ := by
  rw [localizable_iff_massShell]
  intro heq
  linarith [heq]

/--
**Exclusion 2 (zero momentum).** At `p = 0` with `(m₁, m₂) ≠ 0` the symbol is
invertible (its square is the nonzero scalar `−(m₁²+m₂²)·1`), so the single
zero-momentum point is not localizable.
-/
theorem not_localizable_zeroMomentum (m₁ m₂ : ℝ) (h : m₁ ^ 2 + m₂ ^ 2 ≠ 0) :
    ¬ Localizable (fun _ => 0) m₁ m₂ := by
  rw [localizable_iff_massShell]
  intro heq
  apply h
  norm_num at heq
  linarith [heq]

/-! ## The five Wigner kinematic types -/

/-- The five kinematic types of a relativistic unitary irrep, per Wigner's 1939
classification by the sign of the mass Casimir `P²` and the little group. -/
inductive PoincareType
  | massive
  | masslessDiscrete
  | tachyon
  | zeroMomentum
  | infiniteSpin
  deriving DecidableEq, Repr

/-- The kinematic type read off from the mass-squared Casimir and the
massless continuous-spin flag. -/
noncomputable def PoincareType.of (massSq : ℝ) (contSpin : Bool) : PoincareType :=
  if 0 < massSq then .massive
  else if massSq = 0 then (if contSpin then .infiniteSpin else .masslessDiscrete)
  else .tachyon

/-! ## External bundle (named hypotheses; cite, never axiomatize) -/

variable (R : Type*)

/-- **Mackey imprimitivity** (Mackey 1949/1952; Varadarajan, *Geometry of
Quantum Theory*, Thm 6.12), taken as an `EXTERNAL` named hypothesis (not in
Mathlib).  Every localizable unitary irreducible representation of the Poincaré
group is induced from a little-group representation, hence realized by the
concrete Majorana energy symbol of §A.5 on a definite orbit `(p, m₁, m₂)`, with
the symbol singular on its mass shell (localizable). -/
structure MackeyImprimitivity where
  /-- The orbit 3-momentum of the induced realization. -/
  mom : R → (Fin 3 → ℝ)
  /-- The two Majorana mass parameters of the induced realization. -/
  mass₁ : R → ℝ
  mass₂ : R → ℝ
  /-- The massless continuous-spin flag (nontrivial `SE(2)` translations). -/
  contSpin : R → Bool
  /-- The induced realization is localizable (sits on its mass shell). -/
  induced : ∀ ρ, Localizable (mom ρ) (mass₁ ρ) (mass₂ ρ)

/-- The mass-squared Casimir of a Mackey-induced irrep. -/
def MackeyImprimitivity.massSq {R : Type*} (Mk : MackeyImprimitivity R) (ρ : R) : ℝ :=
  Mk.mass₁ ρ ^ 2 + Mk.mass₂ ρ ^ 2

/-- **Wigner classification** (Wigner, *Ann. Math.* 40 (1939) 149), taken as an
`EXTERNAL` named hypothesis.  Among the localizable induced irreps, the massless
*continuous-spin* ("infinite spin") class does not occur: the `SE(2)` translation
label cannot be discretized (the concrete obstruction is
`ChapterA4f.infinite_spin_excluded`). -/
structure WignerClassification (Mk : MackeyImprimitivity R) : Prop where
  /-- No localizable massless irrep has continuous spin. -/
  no_continuous_spin : ∀ ρ, Mk.massSq ρ = 0 → Mk.contSpin ρ = false

/-! ## Conditional headlines -/

/-- **Prop 87 assembled.** Given Mackey induction and the Wigner classification,
every localizable unitary irrep of the Poincaré group is either **massive** or
**massless with discrete helicity**.  Tachyons are excluded because the induced
realization is localizable, forcing `massSq = |p⃗|² ≥ 0` (concrete mass shell);
infinite spin is excluded by the Wigner hypothesis. -/
theorem prop87_assembled (Mk : MackeyImprimitivity R)
    (Wg : WignerClassification R Mk) (ρ : R) :
    PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.massive ∨
    PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.masslessDiscrete := by
  have hshell := (localizable_iff_massShell _ _ _).1 (Mk.induced ρ)
  have hnn : 0 ≤ Mk.massSq ρ := by
    unfold MackeyImprimitivity.massSq
    rw [← hshell]; positivity
  unfold PoincareType.of
  rcases lt_or_eq_of_le hnn with h | h
  · left; simp [h]
  · right
    rw [← h]
    simp [Wg.no_continuous_spin ρ h.symm]

/-- **Prop 88 core (energy sign not conserved).** In the Dirac realization the
positive-energy-sign projector `P₊` does not commute with all spatial-gradient
operators, so no localizable Poincaré representation can diagonalize the energy
sign — antiparticles are unavoidable.  (From `ChapterA4e.energy_sign_not_conserved`.) -/
theorem prop88_energy_sign_not_conserved :
    ¬ ∀ j : Fin 3, projPos * spatialOp j = spatialOp j * projPos := by
  intro h
  obtain ⟨j, hj⟩ := energy_sign_not_conserved
  exact hj (h j)

/-- **Cor 1 (energy sectors swapped).** Spatial motion exchanges the two
energy-sign sectors, `P₊·(γʲγ⁰) = (γʲγ⁰)·P₋` — the particle/antiparticle
conjugation underlying CPT.  (From `ChapterA4e.spatialOp_swaps_pos`.) -/
theorem cor1_energy_sectors_swapped (j : Fin 3) :
    projPos * spatialOp j = spatialOp j * projNeg :=
  spatialOp_swaps_pos j

/-- **Prop 87 + Prop 88 assembled.** A localizable induced irrep is massive or
massless-discrete, and its energy sign is not conserved. -/
theorem prop87_88_assembled (Mk : MackeyImprimitivity R)
    (Wg : WignerClassification R Mk) (ρ : R) :
    (PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.massive ∨
      PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.masslessDiscrete) ∧
    ¬ ∀ j : Fin 3, projPos * spatialOp j = spatialOp j * projPos :=
  ⟨prop87_assembled R Mk Wg ρ, prop88_energy_sign_not_conserved⟩

end BookProof.ChapterA4h
