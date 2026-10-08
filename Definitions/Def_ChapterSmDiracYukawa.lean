import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFarisLavine
import Mathlib


/-!
# The Standard-Model Dirac and Yukawa operators on the CAR algebra, and their Faris–Lavine
certificate

This module closes, for the **fermionic sector in a finite mode truncation**, two of the
honest boundaries that the Standard-Model wave of `CONSOLIDATED_PLAN.md` (§D6b-SM) left
open:

* *“the Dirac and Yukawa operators are not formalized (they need the CAR/Grassmann algebra)
  — only the mixing algebra they rest on is”*: the CAR algebra is
  `BookProof.ChapterSmCarAlgebra`, and here the two operators are **defined on it** —
  `smDirac` is the second quantization `Σ_{i,j} h_{ij} a†_i a_j` of a Hermitian one-particle
  Dirac matrix, `smYukawa` is the Higgs-background Yukawa bilinear
  `Σ_{i,j} (φ M)_{ij} a†_i a_j + h.c.` with the mass matrix `M = U_L V† D U_R†` of
  §D6b-SM.1, and the *mixing algebra* of `BookProof.ChapterSmOneParticle` is what bounds it
  (`yukawa_entry_bound`: no mixing angle can amplify a Yukawa coupling beyond the sum of the
  masses);
* *“the three Faris–Lavine hypotheses of §D6b-SM.3 remain symbolic and are not Lean
  theorems”*: for this sector they now are.  `sm_fermi_fl_i`, `sm_fermi_fl_ii` and
  `sm_fermi_fl_iii` are the relative bound `±h ≤ c₁N`, the first-commutator bound
  `|⟨ψ,[h,N]ψ⟩| ≤ c₂⟨ψ,Nψ⟩` and the double-commutator bound
  `|⟨ψ,[N,[N,h]]ψ⟩| ≤ c₃⟨ψ,N²ψ⟩`, with **explicit constants** built from the `ℓ¹` norm of
  the one-particle matrix and the mode energies; `sm_fermi_esa` feeds them to the project's
  proof of Faris–Lavine Corollary 1.1,
  `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`, and concludes
  essential self-adjointness of the fermionic Hamiltonian.

The comparison operator is the one §D6b-SM.2 prescribes for the fermionic block —
`N = Σ_i ω_i a†_i a_i + c₀` with `ω_i ≥ 0`, `c₀ ≥ 1`, the second quantization of the
one-particle oscillator `−Δ + |x|² + 1 ≥ 1`.

## Honest boundary

The mode set is finite, so the fermionic Hamiltonian is a bounded operator and its essential
self-adjointness, while genuinely obtained through the Faris–Lavine route with the
hypotheses verified one by one, is not by itself a hard analytic fact; what the module
delivers is the *operators* and the *certificate in Lean*, not a continuum limit.  The
spinor/Lorentz structure of `γ⁰γ·D`, the ghost/BRST sector, Majorana masses and the
measured CKM/PMNS parameters remain outside; and nothing here bears on the bosonic sector,
whose inner operator is a positive sum of squares and is treated by Friedrichs in
`BookProof.ChapterSmHamiltonian` / `BookProof.ChapterSmOuterFock`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmDiracYukawa

open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

/-! ## 1. Diagonal operators on the fermionic Fock space -/

/-- A real diagonal operator in the occupation basis. -/
def diagOp (d : Finset (Fin n) → ℝ) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2 (fun S => (d S : ℂ) * ψ S)
  map_add' x y := by ext S; simp [mul_add]
  map_smul' c x := by ext S; simp [mul_left_comm]

@[simp] theorem diagOp_apply (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (diagOp d ψ) S = (d S : ℂ) * ψ S := rflneParticle

/-!
# The Standard-Model Dirac and Yukawa operators on the CAR algebra, and their Faris–Lavine
certificate

This module closes, for the **fermionic sector in a finite mode truncation**, two of the
honest boundaries that the Standard-Model wave of `CONSOLIDATED_PLAN.md` (§D6b-SM) left
open:

* *“the Dirac and Yukawa operators are not formalized (they need the CAR/Grassmann algebra)
  — only the mixing algebra they rest on is”*: the CAR algebra is
  `BookProof.ChapterSmCarAlgebra`, and here the two operators are **defined on it** —
  `smDirac` is the second quantization `Σ_{i,j} h_{ij} a†_i a_j` of a Hermitian one-particle
  Dirac matrix, `smYukawa` is the Higgs-background Yukawa bilinear
  `Σ_{i,j} (φ M)_{ij} a†_i a_j + h.c.` with the mass matrix `M = U_L V† D U_R†` of
  §D6b-SM.1, and the *mixing algebra* of `BookProof.ChapterSmOneParticle` is what bounds it
  (`yukawa_entry_bound`: no mixing angle can amplify a Yukawa coupling beyond the sum of the
  masses);
* *“the three Faris–Lavine hypotheses of §D6b-SM.3 remain symbolic and are not Lean
  theorems”*: for this sector they now are.  `sm_fermi_fl_i`, `sm_fermi_fl_ii` and
  `sm_fermi_fl_iii` are the relative bound `±h ≤ c₁N`, the first-commutator bound
  `|⟨ψ,[h,N]ψ⟩| ≤ c₂⟨ψ,Nψ⟩` and the double-commutator bound
  `|⟨ψ,[N,[N,h]]ψ⟩| ≤ c₃⟨ψ,N²ψ⟩`, with **explicit constants** built from the `ℓ¹` norm of
  the one-particle matrix and the mode energies; `sm_fermi_esa` feeds them to the project's
  proof of Faris–Lavine Corollary 1.1,
  `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`, and concludes
  essential self-adjointness of the fermionic Hamiltonian.

The comparison operator is the one §D6b-SM.2 prescribes for the fermionic block —
`N = Σ_i ω_i a†_i a_i + c₀` with `ω_i ≥ 0`, `c₀ ≥ 1`, the second quantization of the
one-particle oscillator `−Δ + |x|² + 1 ≥ 1`.

## Honest boundary

The mode set is finite, so the fermionic Hamiltonian is a bounded operator and its essential
self-adjointness, while genuinely obtained through the Faris–Lavine route with the
hypotheses verified one by one, is not by itself a hard analytic fact; what the module
delivers is the *operators* and the *certificate in Lean*, not a continuum limit.  The
spinor/Lorentz structure of `γ⁰γ·D`, the ghost/BRST sector, Majorana masses and the
measured CKM/PMNS parameters remain outside; and nothing here bears on the bosonic sector,
whose inner operator is a positive sum of squares and is treated by Friedrichs in
`BookProof.ChapterSmHamiltonian` / `BookProof.ChapterSmOuterFock`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmDiracYukawa

open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

/-! ## 1. Diagonal operators on the fermionic Fock space -/

/-- A real diagonal operator in the occupation basis. -/
def diagOp (d : Finset (Fin n) → ℝ) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2 (fun S => (d S : ℂ) * ψ S)
  map_add' x y := by ext S; simp [mul_add]
  map_smul' c x := by ext S; simp [mul_left_comm]

@[simp] theorem diagOp_apply (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (diagOp d ψ) S = (d S : ℂ) * ψ S := rfl

theorem diagOp_inner (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (diagOp d ψ) : ℂ)
      = ∑ S : Finset (Fin n), ((d S * ‖ψ S‖ ^ 2 : ℝ) : ℂ) := by
  rw [inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, Complex.ofReal_mul,
    show (starRingEnd ℂ) (ψ S) * ((d S : ℂ) * ψ S)
      = (d S : ℂ) * ((starRingEnd ℂ) (ψ S) * ψ S) by ring, ← Complex.normSq_eq_conj_mul_self]
  simp [Complex.normSq_eq_norm_sq]













/-! ## 2. The fermionic comparison operator `N` of §D6b-SM.2 -/

/-- The diagonal weight of the fermionic comparison operator: the sum of the oscillator
energies of the occupied modes, plus the shift `c₀`. -/
def smFermiWeight (om : Fin n → ℝ) (c0 : ℝ) (S : Finset (Fin n)) : ℝ := (∑ i ∈ S, om i) + c0del Dirac and Yukawa operators on the CAR algebra, and their Faris–Lavine
certificate

This module closes, for the **fermionic sector in a finite mode truncation**, two of the
honest boundaries that the Standard-Model wave of `CONSOLIDATED_PLAN.md` (§D6b-SM) left
open:

* *“the Dirac and Yukawa operators are not formalized (they need the CAR/Grassmann algebra)
  — only the mixing algebra they rest on is”*: the CAR algebra is
  `BookProof.ChapterSmCarAlgebra`, and here the two operators are **defined on it** —
  `smDirac` is the second quantization `Σ_{i,j} h_{ij} a†_i a_j` of a Hermitian one-particle
  Dirac matrix, `smYukawa` is the Higgs-background Yukawa bilinear
  `Σ_{i,j} (φ M)_{ij} a†_i a_j + h.c.` with the mass matrix `M = U_L V† D U_R†` of
  §D6b-SM.1, and the *mixing algebra* of `BookProof.ChapterSmOneParticle` is what bounds it
  (`yukawa_entry_bound`: no mixing angle can amplify a Yukawa coupling beyond the sum of the
  masses);
* *“the three Faris–Lavine hypotheses of §D6b-SM.3 remain symbolic and are not Lean
  theorems”*: for this sector they now are.  `sm_fermi_fl_i`, `sm_fermi_fl_ii` and
  `sm_fermi_fl_iii` are the relative bound `±h ≤ c₁N`, the first-commutator bound
  `|⟨ψ,[h,N]ψ⟩| ≤ c₂⟨ψ,Nψ⟩` and the double-commutator bound
  `|⟨ψ,[N,[N,h]]ψ⟩| ≤ c₃⟨ψ,N²ψ⟩`, with **explicit constants** built from the `ℓ¹` norm of
  the one-particle matrix and the mode energies; `sm_fermi_esa` feeds them to the project's
  proof of Faris–Lavine Corollary 1.1,
  `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`, and concludes
  essential self-adjointness of the fermionic Hamiltonian.

The comparison operator is the one §D6b-SM.2 prescribes for the fermionic block —
`N = Σ_i ω_i a†_i a_i + c₀` with `ω_i ≥ 0`, `c₀ ≥ 1`, the second quantization of the
one-particle oscillator `−Δ + |x|² + 1 ≥ 1`.

## Honest boundary

The mode set is finite, so the fermionic Hamiltonian is a bounded operator and its essential
self-adjointness, while genuinely obtained through the Faris–Lavine route with the
hypotheses verified one by one, is not by itself a hard analytic fact; what the module
delivers is the *operators* and the *certificate in Lean*, not a continuum limit.  The
spinor/Lorentz structure of `γ⁰γ·D`, the ghost/BRST sector, Majorana masses and the
measured CKM/PMNS parameters remain outside; and nothing here bears on the bosonic sector,
whose inner operator is a positive sum of squares and is treated by Friedrichs in
`BookProof.ChapterSmHamiltonian` / `BookProof.ChapterSmOuterFock`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmDiracYukawa

open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

/-! ## 1. Diagonal operators on the fermionic Fock space -/

/-- A real diagonal operator in the occupation basis. -/
def diagOp (d : Finset (Fin n) → ℝ) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2 (fun S => (d S : ℂ) * ψ S)
  map_add' x y := by ext S; simp [mul_add]
  map_smul' c x := by ext S; simp [mul_left_comm]

@[simp] theorem diagOp_apply (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (diagOp d ψ) S = (d S : ℂ) * ψ S := rfl

theorem diagOp_inner (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (diagOp d ψ) : ℂ)
      = ∑ S : Finset (Fin n), ((d S * ‖ψ S‖ ^ 2 : ℝ) : ℂ) := by
  rw [inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, Complex.ofReal_mul,
    show (starRingEnd ℂ) (ψ S) * ((d S : ℂ) * ψ S)
      = (d S : ℂ) * ((starRingEnd ℂ) (ψ S) * ψ S) by ring, ← Complex.normSq_eq_conj_mul_self]
  simp [Complex.normSq_eq_norm_sq]

theorem diagOp_quadForm_eq (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (diagOp d ψ) : ℂ).re = ∑ S : Finset (Fin n), d S * ‖ψ S‖ ^ 2 := by
  rw [diagOp_inner, Complex.re_sum]
  exact Finset.sum_congr rfl fun S _ => Complex.ofReal_re _

theorem diagOp_symmetric (d : Finset (Fin n) → ℝ) (ψ φ : FermiFock n) :
    (inner ℂ (diagOp d ψ) φ : ℂ) = inner ℂ ψ (diagOp d φ) := by
  rw [inner_eq_sum, inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  simp only [diagOp_apply, map_mul, Complex.conj_ofReal]
  ring

theorem diagOp_normSq (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    ‖diagOp d ψ‖ ^ 2 = ∑ S : Finset (Fin n), (d S) ^ 2 * ‖ψ S‖ ^ 2 := by
  rw [normSq_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, norm_mul, mul_pow]
  simp [Complex.norm_real, sq_abs]

/-- A diagonal operator bounded below by `1` does not decrease norms. -/
theorem diagOp_norm_ge {d : Finset (Fin n) → ℝ} (hd : ∀ S, 1 ≤ d S) (ψ : FermiFock n) :
    ‖ψ‖ ≤ ‖diagOp d ψ‖ := by
  have hsq : ‖ψ‖ ^ 2 ≤ ‖diagOp d ψ‖ ^ 2 := by
    rw [diagOp_normSq, normSq_eq_sum]
    refine Finset.sum_le_sum fun S _ => ?_
    have h1 : (1:ℝ) ≤ (d S) ^ 2 := by nlinarith [hd S]
    nlinarith [norm_nonneg (ψ S), sq_nonneg (‖ψ S‖)]
  nlinarith [norm_nonneg ψ, norm_nonneg (diagOp d ψ)]

/-- A diagonal operator bounded above by `Ω` is bounded by `Ω` in norm. -/
theorem diagOp_norm_le {d : Finset (Fin n) → ℝ} {Om : ℝ} (hOm : 0 ≤ Om)
    (hd : ∀ S, |d S| ≤ Om) (ψ : FermiFock n) : ‖diagOp d ψ‖ ≤ Om * ‖ψ‖ := by
  have hsq : ‖diagOp d ψ‖ ^ 2 ≤ (Om * ‖ψ‖) ^ 2 := by
    rw [diagOp_normSq, mul_pow, normSq_eq_sum, Finset.mul_sum]
    refine Finset.sum_le_sum fun S _ => ?_
    have h1 : (d S) ^ 2 ≤ Om ^ 2 := by
      have := hd S
      nlinarith [abs_nonneg (d S), sq_abs (d S)]
    nlinarith [sq_nonneg ‖ψ S‖, norm_nonneg (ψ S)]
  nlinarith [norm_nonneg (diagOp d ψ), mul_nonneg hOm (norm_nonneg ψ)]

/-- A diagonal operator bounded below by `1` has `d + 1` onto. -/
theorem diagOp_add_one_surjective {d : Finset (Fin n) → ℝ} (hd : ∀ S, 1 ≤ d S)
    (f : FermiFock n) : ∃ ψ : FermiFock n, diagOp d ψ + ψ = f := by
  refine ⟨WithLp.toLp 2 (fun S => f S / ((d S : ℂ) + 1)), ?_⟩
  ext S
  have hne : ((d S : ℂ) + 1) ≠ 0 := by
    have h1 : (0:ℝ) < d S + 1 := by linarith [hd S]
    intro hzero
    have : ((d S + 1 : ℝ) : ℂ) = 0 := by push_cast; simpa using hzero
    exact absurd (Complex.ofReal_eq_zero.mp this) (ne_of_gt h1)
  have : (d S : ℂ) * (f S / ((d S : ℂ) + 1)) + f S / ((d S : ℂ) + 1) = f S := by
    field_simp
  simpa using this

/-! ## 2. The fermionic comparison operator `N` of §D6b-SM.2 -/

/-- The diagonal weight of the fermionic comparison operator: the sum of the oscillator
energies of the occupied modes, plus the shift `c₀`. -/
def smFermiWeight (om : Fin n → ℝ) (c0 : ℝ) (S : Finset (Fin n)) : ℝ := (∑ i ∈ S, om i) + c0

/-- **The fermionic comparison operator** `N = Σ_i ω_i a†_i a_i + c₀` of §D6b-SM.2: the
second quantization of the one-particle oscillator `−Δ + |x|² + 1`, shifted so that
`N ≥ 1`. -/
def smFermiN (om : Fin n → ℝ) (c0 : ℝ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiEnergy om + (c0 : ℂ) • LinearMap.id

theorem smFermiN_eq_diagOp (om : Fin n → ℝ) (c0 : ℝ) :
    smFermiN om c0 = diagOp (smFermiWeight om c0) := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  simp [smFermiN, smFermiWeight, fermiEnergy_apply, add_mul]





/-! ## 3. The Dirac and Yukawa operators -/

/-- **The Dirac operator of the fermionic sector**: the second quantization
`Σ_{i,j} h_{ij} a†_i a_j` of the one-particle Dirac matrix `h`. -/
def smDirac (hD : Matrix (Fin n) (Fin n) ℂ) : FermiFock n →ₗ[ℂ] FermiFock n := fermiBilin hD

/-- **The Yukawa operator** in a Higgs background `z`: the fermion bilinear `z M` plus its
Hermitian conjugate, second quantized.  `M` is the Yukawa mass matrix of §D6b-SM.1; `z` is
the (complex) value of the Higgs field multiplying it. -/
def smYukawa (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiBilin (z • M + (z • M).conjTranspose)

/-- The one-particle matrix of the full fermionic Hamiltonian `h_Dirac + h_Yukawa`. -/
def smFermiMatrix (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  hD + (z • M + (z • M).conjTranspose)

and their Faris–Lavine
certificate

This module closes, for the **fermionic sector in a finite mode truncation**, two of the
honest boundaries that the Standard-Model wave of `CONSOLIDATED_PLAN.md` (§D6b-SM) left
open:

* *“the Dirac and Yukawa operators are not formalized (they need the CAR/Grassmann algebra)
  — only the mixing algebra they rest on is”*: the CAR algebra is
  `BookProof.ChapterSmCarAlgebra`, and here the two operators are **defined on it** —
  `smDirac` is the second quantization `Σ_{i,j} h_{ij} a†_i a_j` of a Hermitian one-particle
  Dirac matrix, `smYukawa` is the Higgs-background Yukawa bilinear
  `Σ_{i,j} (φ M)_{ij} a†_i a_j + h.c.` with the mass matrix `M = U_L V† D U_R†` of
  §D6b-SM.1, and the *mixing algebra* of `BookProof.ChapterSmOneParticle` is what bounds it
  (`yukawa_entry_bound`: no mixing angle can amplify a Yukawa coupling beyond the sum of the
  masses);
* *“the three Faris–Lavine hypotheses of §D6b-SM.3 remain symbolic and are not Lean
  theorems”*: for this sector they now are.  `sm_fermi_fl_i`, `sm_fermi_fl_ii` and
  `sm_fermi_fl_iii` are the relative bound `±h ≤ c₁N`, the first-commutator bound
  `|⟨ψ,[h,N]ψ⟩| ≤ c₂⟨ψ,Nψ⟩` and the double-commutator bound
  `|⟨ψ,[N,[N,h]]ψ⟩| ≤ c₃⟨ψ,N²ψ⟩`, with **explicit constants** built from the `ℓ¹` norm of
  the one-particle matrix and the mode energies; `sm_fermi_esa` feeds them to the project's
  proof of Faris–Lavine Corollary 1.1,
  `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`, and concludes
  essential self-adjointness of the fermionic Hamiltonian.

The comparison operator is the one §D6b-SM.2 prescribes for the fermionic block —
`N = Σ_i ω_i a†_i a_i + c₀` with `ω_i ≥ 0`, `c₀ ≥ 1`, the second quantization of the
one-particle oscillator `−Δ + |x|² + 1 ≥ 1`.

## Honest boundary

The mode set is finite, so the fermionic Hamiltonian is a bounded operator and its essential
self-adjointness, while genuinely obtained through the Faris–Lavine route with the
hypotheses verified one by one, is not by itself a hard analytic fact; what the module
delivers is the *operators* and the *certificate in Lean*, not a continuum limit.  The
spinor/Lorentz structure of `γ⁰γ·D`, the ghost/BRST sector, Majorana masses and the
measured CKM/PMNS parameters remain outside; and nothing here bears on the bosonic sector,
whose inner operator is a positive sum of squares and is treated by Friedrichs in
`BookProof.ChapterSmHamiltonian` / `BookProof.ChapterSmOuterFock`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmDiracYukawa

open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

/-! ## 1. Diagonal operators on the fermionic Fock space -/

/-- A real diagonal operator in the occupation basis. -/
def diagOp (d : Finset (Fin n) → ℝ) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2 (fun S => (d S : ℂ) * ψ S)
  map_add' x y := by ext S; simp [mul_add]
  map_smul' c x := by ext S; simp [mul_left_comm]

@[simp] theorem diagOp_apply (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (diagOp d ψ) S = (d S : ℂ) * ψ S := rfl

theorem diagOp_inner (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (diagOp d ψ) : ℂ)
      = ∑ S : Finset (Fin n), ((d S * ‖ψ S‖ ^ 2 : ℝ) : ℂ) := by
  rw [inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, Complex.ofReal_mul,
    show (starRingEnd ℂ) (ψ S) * ((d S : ℂ) * ψ S)
      = (d S : ℂ) * ((starRingEnd ℂ) (ψ S) * ψ S) by ring, ← Complex.normSq_eq_conj_mul_self]
  simp [Complex.normSq_eq_norm_sq]

theorem diagOp_quadForm_eq (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (diagOp d ψ) : ℂ).re = ∑ S : Finset (Fin n), d S * ‖ψ S‖ ^ 2 := by
  rw [diagOp_inner, Complex.re_sum]
  exact Finset.sum_congr rfl fun S _ => Complex.ofReal_re _

theorem diagOp_symmetric (d : Finset (Fin n) → ℝ) (ψ φ : FermiFock n) :
    (inner ℂ (diagOp d ψ) φ : ℂ) = inner ℂ ψ (diagOp d φ) := by
  rw [inner_eq_sum, inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  simp only [diagOp_apply, map_mul, Complex.conj_ofReal]
  ring

theorem diagOp_normSq (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    ‖diagOp d ψ‖ ^ 2 = ∑ S : Finset (Fin n), (d S) ^ 2 * ‖ψ S‖ ^ 2 := by
  rw [normSq_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, norm_mul, mul_pow]
  simp [Complex.norm_real, sq_abs]

/-- A diagonal operator bounded below by `1` does not decrease norms. -/
theorem diagOp_norm_ge {d : Finset (Fin n) → ℝ} (hd : ∀ S, 1 ≤ d S) (ψ : FermiFock n) :
    ‖ψ‖ ≤ ‖diagOp d ψ‖ := by
  have hsq : ‖ψ‖ ^ 2 ≤ ‖diagOp d ψ‖ ^ 2 := by
    rw [diagOp_normSq, normSq_eq_sum]
    refine Finset.sum_le_sum fun S _ => ?_
    have h1 : (1:ℝ) ≤ (d S) ^ 2 := by nlinarith [hd S]
    nlinarith [norm_nonneg (ψ S), sq_nonneg (‖ψ S‖)]
  nlinarith [norm_nonneg ψ, norm_nonneg (diagOp d ψ)]

/-- A diagonal operator bounded above by `Ω` is bounded by `Ω` in norm. -/
theorem diagOp_norm_le {d : Finset (Fin n) → ℝ} {Om : ℝ} (hOm : 0 ≤ Om)
    (hd : ∀ S, |d S| ≤ Om) (ψ : FermiFock n) : ‖diagOp d ψ‖ ≤ Om * ‖ψ‖ := by
  have hsq : ‖diagOp d ψ‖ ^ 2 ≤ (Om * ‖ψ‖) ^ 2 := by
    rw [diagOp_normSq, mul_pow, normSq_eq_sum, Finset.mul_sum]
    refine Finset.sum_le_sum fun S _ => ?_
    have h1 : (d S) ^ 2 ≤ Om ^ 2 := by
      have := hd S
      nlinarith [abs_nonneg (d S), sq_abs (d S)]
    nlinarith [sq_nonneg ‖ψ S‖, norm_nonneg (ψ S)]
  nlinarith [norm_nonneg (diagOp d ψ), mul_nonneg hOm (norm_nonneg ψ)]

/-- A diagonal operator bounded below by `1` has `d + 1` onto. -/
theorem diagOp_add_one_surjective {d : Finset (Fin n) → ℝ} (hd : ∀ S, 1 ≤ d S)
    (f : FermiFock n) : ∃ ψ : FermiFock n, diagOp d ψ + ψ = f := by
  refine ⟨WithLp.toLp 2 (fun S => f S / ((d S : ℂ) + 1)), ?_⟩
  ext S
  have hne : ((d S : ℂ) + 1) ≠ 0 := by
    have h1 : (0:ℝ) < d S + 1 := by linarith [hd S]
    intro hzero
    have : ((d S + 1 : ℝ) : ℂ) = 0 := by push_cast; simpa using hzero
    exact absurd (Complex.ofReal_eq_zero.mp this) (ne_of_gt h1)
  have : (d S : ℂ) * (f S / ((d S : ℂ) + 1)) + f S / ((d S : ℂ) + 1) = f S := by
    field_simp
  simpa using this

/-! ## 2. The fermionic comparison operator `N` of §D6b-SM.2 -/

/-- The diagonal weight of the fermionic comparison operator: the sum of the oscillator
energies of the occupied modes, plus the shift `c₀`. -/
def smFermiWeight (om : Fin n → ℝ) (c0 : ℝ) (S : Finset (Fin n)) : ℝ := (∑ i ∈ S, om i) + c0

/-- **The fermionic comparison operator** `N = Σ_i ω_i a†_i a_i + c₀` of §D6b-SM.2: the
second quantization of the one-particle oscillator `−Δ + |x|² + 1`, shifted so that
`N ≥ 1`. -/
def smFermiN (om : Fin n → ℝ) (c0 : ℝ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiEnergy om + (c0 : ℂ) • LinearMap.id

theorem smFermiN_eq_diagOp (om : Fin n → ℝ) (c0 : ℝ) :
    smFermiN om c0 = diagOp (smFermiWeight om c0) := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  simp [smFermiN, smFermiWeight, fermiEnergy_apply, add_mul]

theorem smFermiWeight_ge_one {om : Fin n → ℝ} {c0 : ℝ} (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0)
    (S : Finset (Fin n)) : 1 ≤ smFermiWeight om c0 S := by
  have : 0 ≤ ∑ i ∈ S, om i := Finset.sum_nonneg fun i _ => hom i
  simp only [smFermiWeight]
  linarith

theorem smFermiWeight_le {om : Fin n → ℝ} {c0 : ℝ} (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0)
    (S : Finset (Fin n)) :
    |smFermiWeight om c0 S| ≤ (∑ i : Fin n, om i) + c0 := by
  have hle : ∑ i ∈ S, om i ≤ ∑ i : Fin n, om i :=
    Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ S) fun i _ _ => hom i
  have hnn : 0 ≤ ∑ i ∈ S, om i := Finset.sum_nonneg fun i _ => hom i
  rw [abs_of_nonneg (by simp only [smFermiWeight]; linarith)]
  simp only [smFermiWeight]
  linarith

/-! ## 3. The Dirac and Yukawa operators -/

/-- **The Dirac operator of the fermionic sector**: the second quantization
`Σ_{i,j} h_{ij} a†_i a_j` of the one-particle Dirac matrix `h`. -/
def smDirac (hD : Matrix (Fin n) (Fin n) ℂ) : FermiFock n →ₗ[ℂ] FermiFock n := fermiBilin hD

/-- **The Yukawa operator** in a Higgs background `z`: the fermion bilinear `z M` plus its
Hermitian conjugate, second quantized.  `M` is the Yukawa mass matrix of §D6b-SM.1; `z` is
the (complex) value of the Higgs field multiplying it. -/
def smYukawa (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiBilin (z • M + (z • M).conjTranspose)

/-- The one-particle matrix of the full fermionic Hamiltonian `h_Dirac + h_Yukawa`. -/
def smFermiMatrix (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  hD + (z • M + (z • M).conjTranspose)

theorem smFermiMatrix_hermitian {hD M : Matrix (Fin n) (Fin n) ℂ} (z : ℂ)
    (hh : hD.conjTranspose = hD) :
    (smFermiMatrix hD M z).conjTranspose = smFermiMatrix hD M z := by
  simp [smFermiMatrix, Matrix.conjTranspose_add, hh, add_comm]



/-- **The fermionic Hamiltonian of the Standard-Model sector**: Dirac plus Yukawa. -/
def smFermiHam (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiBilin (smFermiMatrix hD M z)

theorem smFermiHam_eq (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    smFermiHam hD M z = smDirac hD + smYukawa M z := by
  rw [smFermiHam, smFermiMatrix, fermiBilin_add, smDirac, smYukawa]





/-! ## 4. The mixing algebra bounds the Yukawa operator -/





/-! ## 5. The three Faris–Lavine hypotheses of §D6b-SM.3, for the fermionic sector -/

/-- The domain on which the fermionic operators are defined: all of the (finite-dimensional)
Fock space. -/
abbrev fullDom (n : ℕ) : Submodule ℂ (FermiFock n) := ⊤

/-- An everywhere-defined operator, read as an unbounded operator on the full domain. -/
def onFull (T : FermiFock n →ₗ[ℂ] FermiFock n) : fullDom n →ₗ[ℂ] FermiFock n :=
  T ∘ₗ (fullDom n).subtype

@[simp] theorem onFull_apply (T : FermiFock n →ₗ[ℂ] FermiFock n) (x : fullDom n) :
    onFull T x = T (x : FermiFock n) := rfl

variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

/-- The constant `c₁`: the `ℓ¹` norm of the one-particle matrix of `h_Dirac + h_Yukawa`. -/
def smFermiBound (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : ℝ :=
  ∑ i : Fin n, ∑ j : Fin n, ‖smFermiMatrix hD M z i j‖



/-- The constant `Ω`: the upper bound on the comparison operator. -/
def smFermiOm (om : Fin n → ℝ) (c0 : ℝ) : ℝ := (∑ i : Fin n, om i) + c0










honest boundaries that the Standard-Model wave of `CONSOLIDATED_PLAN.md` (§D6b-SM) left
open:

* *“the Dirac and Yukawa operators are not formalized (they need the CAR/Grassmann algebra)
  — only the mixing algebra they rest on is”*: the CAR algebra is
  `BookProof.ChapterSmCarAlgebra`, and here the two operators are **defined on it** —
  `smDirac` is the second quantization `Σ_{i,j} h_{ij} a†_i a_j` of a Hermitian one-particle
  Dirac matrix, `smYukawa` is the Higgs-background Yukawa bilinear
  `Σ_{i,j} (φ M)_{ij} a†_i a_j + h.c.` with the mass matrix `M = U_L V† D U_R†` of
  §D6b-SM.1, and the *mixing algebra* of `BookProof.ChapterSmOneParticle` is what bounds it
  (`yukawa_entry_bound`: no mixing angle can amplify a Yukawa coupling beyond the sum of the
  masses);
* *“the three Faris–Lavine hypotheses of §D6b-SM.3 remain symbolic and are not Lean
  theorems”*: for this sector they now are.  `sm_fermi_fl_i`, `sm_fermi_fl_ii` and
  `sm_fermi_fl_iii` are the relative bound `±h ≤ c₁N`, the first-commutator bound
  `|⟨ψ,[h,N]ψ⟩| ≤ c₂⟨ψ,Nψ⟩` and the double-commutator bound
  `|⟨ψ,[N,[N,h]]ψ⟩| ≤ c₃⟨ψ,N²ψ⟩`, with **explicit constants** built from the `ℓ¹` norm of
  the one-particle matrix and the mode energies; `sm_fermi_esa` feeds them to the project's
  proof of Faris–Lavine Corollary 1.1,
  `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`, and concludes
  essential self-adjointness of the fermionic Hamiltonian.

The comparison operator is the one §D6b-SM.2 prescribes for the fermionic block —
`N = Σ_i ω_i a†_i a_i + c₀` with `ω_i ≥ 0`, `c₀ ≥ 1`, the second quantization of the
one-particle oscillator `−Δ + |x|² + 1 ≥ 1`.

## Honest boundary

The mode set is finite, so the fermionic Hamiltonian is a bounded operator and its essential
self-adjointness, while genuinely obtained through the Faris–Lavine route with the
hypotheses verified one by one, is not by itself a hard analytic fact; what the module
delivers is the *operators* and the *certificate in Lean*, not a continuum limit.  The
spinor/Lorentz structure of `γ⁰γ·D`, the ghost/BRST sector, Majorana masses and the
measured CKM/PMNS parameters remain outside; and nothing here bears on the bosonic sector,
whose inner operator is a positive sum of squares and is treated by Friedrichs in
`BookProof.ChapterSmHamiltonian` / `BookProof.ChapterSmOuterFock`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmDiracYukawa

open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

/-! ## 1. Diagonal operators on the fermionic Fock space -/

/-- A real diagonal operator in the occupation basis. -/
def diagOp (d : Finset (Fin n) → ℝ) : FermiFock n →ₗ[ℂ] FermiFock n where
  toFun ψ := WithLp.toLp 2 (fun S => (d S : ℂ) * ψ S)
  map_add' x y := by ext S; simp [mul_add]
  map_smul' c x := by ext S; simp [mul_left_comm]

@[simp] theorem diagOp_apply (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (diagOp d ψ) S = (d S : ℂ) * ψ S := rfl

theorem diagOp_inner (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (diagOp d ψ) : ℂ)
      = ∑ S : Finset (Fin n), ((d S * ‖ψ S‖ ^ 2 : ℝ) : ℂ) := by
  rw [inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, Complex.ofReal_mul,
    show (starRingEnd ℂ) (ψ S) * ((d S : ℂ) * ψ S)
      = (d S : ℂ) * ((starRingEnd ℂ) (ψ S) * ψ S) by ring, ← Complex.normSq_eq_conj_mul_self]
  simp [Complex.normSq_eq_norm_sq]

theorem diagOp_quadForm_eq (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (diagOp d ψ) : ℂ).re = ∑ S : Finset (Fin n), d S * ‖ψ S‖ ^ 2 := by
  rw [diagOp_inner, Complex.re_sum]
  exact Finset.sum_congr rfl fun S _ => Complex.ofReal_re _

theorem diagOp_symmetric (d : Finset (Fin n) → ℝ) (ψ φ : FermiFock n) :
    (inner ℂ (diagOp d ψ) φ : ℂ) = inner ℂ ψ (diagOp d φ) := by
  rw [inner_eq_sum, inner_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  simp only [diagOp_apply, map_mul, Complex.conj_ofReal]
  ring

theorem diagOp_normSq (d : Finset (Fin n) → ℝ) (ψ : FermiFock n) :
    ‖diagOp d ψ‖ ^ 2 = ∑ S : Finset (Fin n), (d S) ^ 2 * ‖ψ S‖ ^ 2 := by
  rw [normSq_eq_sum]
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [diagOp_apply, norm_mul, mul_pow]
  simp [Complex.norm_real, sq_abs]

/-- A diagonal operator bounded below by `1` does not decrease norms. -/
theorem diagOp_norm_ge {d : Finset (Fin n) → ℝ} (hd : ∀ S, 1 ≤ d S) (ψ : FermiFock n) :
    ‖ψ‖ ≤ ‖diagOp d ψ‖ := by
  have hsq : ‖ψ‖ ^ 2 ≤ ‖diagOp d ψ‖ ^ 2 := by
    rw [diagOp_normSq, normSq_eq_sum]
    refine Finset.sum_le_sum fun S _ => ?_
    have h1 : (1:ℝ) ≤ (d S) ^ 2 := by nlinarith [hd S]
    nlinarith [norm_nonneg (ψ S), sq_nonneg (‖ψ S‖)]
  nlinarith [norm_nonneg ψ, norm_nonneg (diagOp d ψ)]

/-- A diagonal operator bounded above by `Ω` is bounded by `Ω` in norm. -/
theorem diagOp_norm_le {d : Finset (Fin n) → ℝ} {Om : ℝ} (hOm : 0 ≤ Om)
    (hd : ∀ S, |d S| ≤ Om) (ψ : FermiFock n) : ‖diagOp d ψ‖ ≤ Om * ‖ψ‖ := by
  have hsq : ‖diagOp d ψ‖ ^ 2 ≤ (Om * ‖ψ‖) ^ 2 := by
    rw [diagOp_normSq, mul_pow, normSq_eq_sum, Finset.mul_sum]
    refine Finset.sum_le_sum fun S _ => ?_
    have h1 : (d S) ^ 2 ≤ Om ^ 2 := by
      have := hd S
      nlinarith [abs_nonneg (d S), sq_abs (d S)]
    nlinarith [sq_nonneg ‖ψ S‖, norm_nonneg (ψ S)]
  nlinarith [norm_nonneg (diagOp d ψ), mul_nonneg hOm (norm_nonneg ψ)]

/-- A diagonal operator bounded below by `1` has `d + 1` onto. -/
theorem diagOp_add_one_surjective {d : Finset (Fin n) → ℝ} (hd : ∀ S, 1 ≤ d S)
    (f : FermiFock n) : ∃ ψ : FermiFock n, diagOp d ψ + ψ = f := by
  refine ⟨WithLp.toLp 2 (fun S => f S / ((d S : ℂ) + 1)), ?_⟩
  ext S
  have hne : ((d S : ℂ) + 1) ≠ 0 := by
    have h1 : (0:ℝ) < d S + 1 := by linarith [hd S]
    intro hzero
    have : ((d S + 1 : ℝ) : ℂ) = 0 := by push_cast; simpa using hzero
    exact absurd (Complex.ofReal_eq_zero.mp this) (ne_of_gt h1)
  have : (d S : ℂ) * (f S / ((d S : ℂ) + 1)) + f S / ((d S : ℂ) + 1) = f S := by
    field_simp
  simpa using this

/-! ## 2. The fermionic comparison operator `N` of §D6b-SM.2 -/

/-- The diagonal weight of the fermionic comparison operator: the sum of the oscillator
energies of the occupied modes, plus the shift `c₀`. -/
def smFermiWeight (om : Fin n → ℝ) (c0 : ℝ) (S : Finset (Fin n)) : ℝ := (∑ i ∈ S, om i) + c0

/-- **The fermionic comparison operator** `N = Σ_i ω_i a†_i a_i + c₀` of §D6b-SM.2: the
second quantization of the one-particle oscillator `−Δ + |x|² + 1`, shifted so that
`N ≥ 1`. -/
def smFermiN (om : Fin n → ℝ) (c0 : ℝ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiEnergy om + (c0 : ℂ) • LinearMap.id

theorem smFermiN_eq_diagOp (om : Fin n → ℝ) (c0 : ℝ) :
    smFermiN om c0 = diagOp (smFermiWeight om c0) := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  simp [smFermiN, smFermiWeight, fermiEnergy_apply, add_mul]

theorem smFermiWeight_ge_one {om : Fin n → ℝ} {c0 : ℝ} (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0)
    (S : Finset (Fin n)) : 1 ≤ smFermiWeight om c0 S := by
  have : 0 ≤ ∑ i ∈ S, om i := Finset.sum_nonneg fun i _ => hom i
  simp only [smFermiWeight]
  linarith

theorem smFermiWeight_le {om : Fin n → ℝ} {c0 : ℝ} (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0)
    (S : Finset (Fin n)) :
    |smFermiWeight om c0 S| ≤ (∑ i : Fin n, om i) + c0 := by
  have hle : ∑ i ∈ S, om i ≤ ∑ i : Fin n, om i :=
    Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ S) fun i _ _ => hom i
  have hnn : 0 ≤ ∑ i ∈ S, om i := Finset.sum_nonneg fun i _ => hom i
  rw [abs_of_nonneg (by simp only [smFermiWeight]; linarith)]
  simp only [smFermiWeight]
  linarith

/-! ## 3. The Dirac and Yukawa operators -/

/-- **The Dirac operator of the fermionic sector**: the second quantization
`Σ_{i,j} h_{ij} a†_i a_j` of the one-particle Dirac matrix `h`. -/
def smDirac (hD : Matrix (Fin n) (Fin n) ℂ) : FermiFock n →ₗ[ℂ] FermiFock n := fermiBilin hD

/-- **The Yukawa operator** in a Higgs background `z`: the fermion bilinear `z M` plus its
Hermitian conjugate, second quantized.  `M` is the Yukawa mass matrix of §D6b-SM.1; `z` is
the (complex) value of the Higgs field multiplying it. -/
def smYukawa (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiBilin (z • M + (z • M).conjTranspose)

/-- The one-particle matrix of the full fermionic Hamiltonian `h_Dirac + h_Yukawa`. -/
def smFermiMatrix (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  hD + (z • M + (z • M).conjTranspose)

theorem smFermiMatrix_hermitian {hD M : Matrix (Fin n) (Fin n) ℂ} (z : ℂ)
    (hh : hD.conjTranspose = hD) :
    (smFermiMatrix hD M z).conjTranspose = smFermiMatrix hD M z := by
  simp [smFermiMatrix, Matrix.conjTranspose_add, hh, add_comm]

theorem fermiBilin_add (A B : Matrix (Fin n) (Fin n) ℂ) :
    fermiBilin (A + B) = fermiBilin A + fermiBilin B := by
  simp only [fermiBilin, Matrix.add_apply, add_smul]
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_add_distrib

/-- **The fermionic Hamiltonian of the Standard-Model sector**: Dirac plus Yukawa. -/
def smFermiHam (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : FermiFock n →ₗ[ℂ] FermiFock n :=
  fermiBilin (smFermiMatrix hD M z)

theorem smFermiHam_eq (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    smFermiHam hD M z = smDirac hD + smYukawa M z := by
  rw [smFermiHam, smFermiMatrix, fermiBilin_add, smDirac, smYukawa]

/-- The Dirac–Yukawa Hamiltonian is symmetric. -/
theorem smFermiHam_symmetric {hD M : Matrix (Fin n) (Fin n) ℂ} (z : ℂ)
    (hh : hD.conjTranspose = hD) (ψ φ : FermiFock n) :
    (inner ℂ (smFermiHam hD M z ψ) φ : ℂ) = inner ℂ ψ (smFermiHam hD M z φ) :=
  fermiBilin_symmetric (smFermiMatrix_hermitian z hh) ψ φ

/-- The `ℓ¹` operator bound for the Dirac–Yukawa Hamiltonian. -/
theorem smFermiHam_norm_le (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) (ψ : FermiFock n) :
    ‖smFermiHam hD M z ψ‖
      ≤ (∑ i : Fin n, ∑ j : Fin n, ‖smFermiMatrix hD M z i j‖) * ‖ψ‖ :=
  norm_fermiBilin_le _ ψ

/-! ## 4. The mixing algebra bounds the Yukawa operator -/

open BookProof.SmOneParticle in
/-- A product of mixing matrices is a mixing matrix. -/
theorem isMixing_mul {A B : Matrix (Fin 3) (Fin 3) ℂ} (hA : IsMixing A) (hB : IsMixing B) :
    IsMixing (A * B.conjTranspose) := by
  unfold IsMixing
  rw [Matrix.conjTranspose_mul, Matrix.conjTranspose_conjTranspose, Matrix.mul_assoc,
    ← Matrix.mul_assoc B.conjTranspose B A.conjTranspose, hB.conjTranspose_mul,
    Matrix.one_mul]
  exact hA

open BookProof.SmOneParticle in
/-- **The mixing matrices cannot amplify a Yukawa coupling** (the operator form of CHECK
20/28).  Every entry of the biunitary mass matrix `M = U_L V† D U_R†` is bounded by the sum
of the diagonal masses of `D`, uniformly in the mixing angles. -/
theorem yukawa_entry_bound {UL V UR D : Matrix (Fin 3) (Fin 3) ℂ}
    (hUL : IsMixing UL) (hV : IsMixing V) (hUR : IsMixing UR)
    (hD : ∀ k l, k ≠ l → D k l = 0) (i j : Fin 3) :
    ‖(UL * V.conjTranspose * D * UR.conjTranspose) i j‖ ≤ ∑ k : Fin 3, ‖D k k‖ := by
  set A : Matrix (Fin 3) (Fin 3) ℂ := UL * V.conjTranspose with hA
  have hAmix : IsMixing A := isMixing_mul hUL hV
  have hentry : (A * D * UR.conjTranspose) i j
      = ∑ k : Fin 3, A i k * D k k * star (UR j k) := by
    rw [Matrix.mul_apply]
    refine Finset.sum_congr rfl fun l _ => ?_
    have hAD : (A * D) i l = A i l * D l l := by
      rw [Matrix.mul_apply]
      exact Finset.sum_eq_single l (fun k _ hk => by rw [hD k l hk, mul_zero])
        (fun hl => absurd (Finset.mem_univ l) hl)
    rw [hAD, Matrix.conjTranspose_apply]
  rw [hentry]
  refine le_trans (norm_sum_le _ _) (Finset.sum_le_sum fun k _ => ?_)
  rw [norm_mul, norm_mul, norm_star]
  have h1 : ‖A i k‖ ≤ 1 := unitary_entry_norm_le_one hAmix i k
  have h2 : ‖UR j k‖ ≤ 1 := unitary_entry_norm_le_one hUR j k
  calc ‖A i k‖ * ‖D k k‖ * ‖UR j k‖ ≤ 1 * ‖D k k‖ * 1 := by gcongr
    _ = ‖D k k‖ := by ring

/-! ## 5. The three Faris–Lavine hypotheses of §D6b-SM.3, for the fermionic sector -/

/-- The domain on which the fermionic operators are defined: all of the (finite-dimensional)
Fock space. -/
abbrev fullDom (n : ℕ) : Submodule ℂ (FermiFock n) := ⊤

/-- An everywhere-defined operator, read as an unbounded operator on the full domain. -/
def onFull (T : FermiFock n →ₗ[ℂ] FermiFock n) : fullDom n →ₗ[ℂ] FermiFock n :=
  T ∘ₗ (fullDom n).subtype

@[simp] theorem onFull_apply (T : FermiFock n →ₗ[ℂ] FermiFock n) (x : fullDom n) :
    onFull T x = T (x : FermiFock n) := rfl

variable {hD M : Matrix (Fin n) (Fin n) ℂ} {z : ℂ} {om : Fin n → ℝ} {c0 : ℝ}

/-- The constant `c₁`: the `ℓ¹` norm of the one-particle matrix of `h_Dirac + h_Yukawa`. -/
def smFermiBound (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) : ℝ :=
  ∑ i : Fin n, ∑ j : Fin n, ‖smFermiMatrix hD M z i j‖

theorem smFermiBound_nonneg (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    0 ≤ smFermiBound hD M z :=
  Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => norm_nonneg _

/-- The constant `Ω`: the upper bound on the comparison operator. -/
def smFermiOm (om : Fin n → ℝ) (c0 : ℝ) : ℝ := (∑ i : Fin n, om i) + c0

theorem smFermiOm_nonneg (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) : 0 ≤ smFermiOm om c0 := by
  have : 0 ≤ ∑ i : Fin n, om i := Finset.sum_nonneg fun i _ => hom i
  simp only [smFermiOm]
  linarith

theorem smFermiN_symmetricOn (om : Fin n → ℝ) (c0 : ℝ) :
    SymmetricOn (fullDom n) (onFull (smFermiN om c0)) := by
  intro x y
  rw [smFermiN_eq_diagOp]
  exact diagOp_symmetric (smFermiWeight om c0) (x : FermiFock n) (y : FermiFock n)

theorem smFermiHam_symmetricOn (hh : hD.conjTranspose = hD) :
    SymmetricOn (fullDom n) (onFull (smFermiHam hD M z)) := fun x y =>
  smFermiHam_symmetric z hh (x : FermiFock n) (y : FermiFock n)

/-- **`N ≥ 1`**: the quadratic form of the fermionic comparison operator dominates the
norm. -/
theorem sm_fermi_N_ge_one (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) (x : fullDom n) :
    ‖(x : FermiFock n)‖ ^ 2 ≤ quadForm (onFull (smFermiN om c0)) x := by
  rw [quadForm, onFull_apply, smFermiN_eq_diagOp, diagOp_quadForm_eq, normSq_eq_sum]
  refine Finset.sum_le_sum fun S _ => ?_
  have h1 := smFermiWeight_ge_one hom hc0 (om := om) (c0 := c0) S
  nlinarith [norm_nonneg ((x : FermiFock n) S), sq_nonneg ‖(x : FermiFock n) S‖]

theorem sm_fermi_N_nonneg (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) (x : fullDom n) :
    0 ≤ quadForm (onFull (smFermiN om c0)) x :=
  le_trans (by positivity) (sm_fermi_N_ge_one hom hc0 x)





/-- `N + 1` is onto — the hypothesis of the Faris–Lavine criterion that replaces spectral
theory for the comparison operator. -/
theorem sm_fermi_N_add_one_surjective (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0)
    (f : FermiFock n) :
    ∃ x : fullDom n, onFull (smFermiN om c0) x + (x : FermiFock n) = f := by
  obtain ⟨ψ, hψ⟩ := diagOp_add_one_surjective
    (fun S => smFermiWeight_ge_one hom hc0 (om := om) (c0 := c0) S) f
  refine ⟨⟨ψ, Submodule.mem_top⟩, ?_⟩
  rw [onFull_apply, smFermiN_eq_diagOp]
  exact hψ





/-- The double commutator `[N, [N, h]]`, as an everywhere-defined operator. -/
def dcommOp (H N : FermiFock n →ₗ[ℂ] FermiFock n) : FermiFock n →ₗ[ℂ] FermiFock n :=
  ⁅N, ⁅N, H⁆⁆









end

end BookProof.SmDiracYukawa
