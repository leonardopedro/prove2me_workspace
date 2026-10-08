import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsSU3
import Definitions.Def_ChapterSmCarAlgebra
import Mathlib


/-!
# The ghost / BRST sector of the Standard-Model gauge algebra

This module closes the third honest boundary of the Standard-Model wave of
`CONSOLIDATED_PLAN.md` §D6b-SM: *“the ghost/BRST sector is not built”*.  The Grassmann
coordinates `ζ_F` of §D6b-SM.1 carry, besides the matter fermions, **one ghost per gauge
generator**; the Standard-Model gauge algebra `su(3) ⊕ su(2) ⊕ u(1)` has `8 + 3 + 1 = 12`
generators, so the ghost sector is a twelve-mode CAR algebra, and the BRST charge is

```
Ω = Σ_a c^a G_a − ½ Σ_{a,b,c} f_{abc} c^a c^b b_c .
```

## What is proved

* **The structure constants of the Standard-Model gauge algebra.**  `sumStruct` is the
  direct sum of two structure-constant families, `sumStruct_antisymm` and
  `sumStruct_jacobi` show that antisymmetry and the Jacobi identity are inherited;
  `su2Struct` is the concrete `su(2)` Levi-Civita family (antisymmetry and Jacobi by finite
  check), `u1Struct` the abelian one, and `smStruct f₃` assembles them with an `su(3)`
  family `f₃` into the twelve-generator family, with **`smStruct_antisymm`** and
  **`smStruct_jacobi`**: the Standard-Model gauge algebra has totally antisymmetric
  structure constants obeying Jacobi, which is exactly what BRST needs.
* **The ghost sector on the CAR algebra.**  The ghosts are the last twelve modes of the
  fermionic Fock space of `BookProof.ChapterSmCarAlgebra`; `smGhostCAR` is their canonical
  anticommutation relations, `ghostNumber` the ghost-number operator with
  `ghostNumber_occ` (its spectrum is the ghost occupation number) and the commutators
  `ghostNumber_comm_ghostCre`, `ghostNumber_comm_ghostAnn`.
* **The cubic ghost charge is nilpotent** — `smGhostCharge_nilpotent`, through the project's
  `BookProof.BRSTNilpotent.brst_charge_nilpotent` with the Standard-Model structure
  constants.
* **The full BRST charge is nilpotent** — `brstCharge_nilpotent`, an algebraic theorem in
  any ring carrying ghosts with the CAR and constraint operators `G_a` that commute with
  the ghosts and close with the structure constants: `Ω² = 0`.
* **Second quantization is a Lie-algebra homomorphism** — `fermiBilin_lie`,
  `creat_annih_commutator`: `[dΓ(A), dΓ(B)] = dΓ([A,B])`, so the Gauss-law generators
  `G_a = −i dΓ(T_a)` of the matter sector close with the *real* structure constants
  (`matterGen_lie`), and they commute with the ghosts (`matterGen_comm_ghostCre`,
  `matterGen_comm_ghostAnn`) because they are even.
* **The Standard-Model BRST charge** `smBrstCharge` on the joint matter ⊗ ghost Fock space,
  with **`smBrstCharge_nilpotent`**: `Ω² = 0`, which is what makes the BRST cohomology —
  the physical sector — well defined.

## Honest boundary

The mode set here is finite: one plane-wave matter multiplet and the twelve ghosts, i.e. the
gauge algebra of the collective-coordinate presentation of §D6b-SM.1.  The charge used in
this module is the abstract one, with the constraints `G_a` given as data.  The BRST charge
**as `book.tex` itself defines it** — the density
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc}A_{μb}ψ†_c − (i/2) f_{abc}ψ†_aψ†_bψ_c` with the book's
canonical relations, the Gauss law *derived* from them, and the gauge-fixing fermion
`Ψ = i ψ_a A_{0a}` — is built in `BookProof.ChapterBookBrstYangMills`,
`BookProof.ChapterBookBrstGaugeFixing` and `BookProof.ChapterBookBrstInstances`, the last of
which instantiates it with the Standard-Model structure constants `smStruct f₃`.  The
`su(3)` structure constants enter as a family satisfying antisymmetry and Jacobi (which
`BookProof.ChapterYangMillsSU3` derives for trace-orthonormal generators); the book's
formalism uses no Faddeev–Popov determinant and none is constructed, and no statement about
the *size* of the BRST cohomology is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmBrstGhost

open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

/-! ## 1. The structure constants of `su(3) ⊕ su(2) ⊕ u(1)` -/

/-- The direct sum of two families of structure constants: a bracket never leaves its
summand. -/
def sumStruct {ι κ : Type*} (f1 : ι → ι → ι → ℝ) (f2 : κ → κ → κ → ℝ) :
    (ι ⊕ κ) → (ι ⊕ κ) → (ι ⊕ κ) → ℝ
  | Sum.inl a, Sum.inl b, Sum.inl c => f1 a b c
  | Sum.inr a, Sum.inr b, Sum.inr c => f2 a b c
  | _, _, _ => 0





/-- The Levi-Civita symbol on three indices, as an integer. -/
def epsZ (a b c : Fin 3) : ℤ :=
  if a = b ∨ b = c ∨ a = c then 0
  else if (a, b) = ((0 : Fin 3), (1 : Fin 3)) ∨ (a, b) = ((1 : Fin 3), (2 : Fin 3))
        ∨ (a, b) = ((2 : Fin 3), (0 : Fin 3)) then 1 else -1

/-- **The `su(2)` structure constants** `ε_{jkl}`. -/
def su2Struct (a b c : Fin 3) : ℝ := (epsZ a b c : ℝ)

/-- **The `u(1)` structure constants**: an abelian factor has none. -/
def u1Struct (_ _ _ : Fin 1) : ℝ := 0



 ghost / BRST sector of the Standard-Model gauge algebra

This module closes the third honest boundary of the Standard-Model wave of
`CONSOLIDATED_PLAN.md` §D6b-SM: *“the ghost/BRST sector is not built”*.  The Grassmann
coordinates `ζ_F` of §D6b-SM.1 carry, besides the matter fermions, **one ghost per gauge
generator**; the Standard-Model gauge algebra `su(3) ⊕ su(2) ⊕ u(1)` has `8 + 3 + 1 = 12`
generators, so the ghost sector is a twelve-mode CAR algebra, and the BRST charge is

```
Ω = Σ_a c^a G_a − ½ Σ_{a,b,c} f_{abc} c^a c^b b_c .
```

## What is proved

* **The structure constants of the Standard-Model gauge algebra.**  `sumStruct` is the
  direct sum of two structure-constant families, `sumStruct_antisymm` and
  `sumStruct_jacobi` show that antisymmetry and the Jacobi identity are inherited;
  `su2Struct` is the concrete `su(2)` Levi-Civita family (antisymmetry and Jacobi by finite
  check), `u1Struct` the abelian one, and `smStruct f₃` assembles them with an `su(3)`
  family `f₃` into the twelve-generator family, with **`smStruct_antisymm`** and
  **`smStruct_jacobi`**: the Standard-Model gauge algebra has totally antisymmetric
  structure constants obeying Jacobi, which is exactly what BRST needs.
* **The ghost sector on the CAR algebra.**  The ghosts are the last twelve modes of the
  fermionic Fock space of `BookProof.ChapterSmCarAlgebra`; `smGhostCAR` is their canonical
  anticommutation relations, `ghostNumber` the ghost-number operator with
  `ghostNumber_occ` (its spectrum is the ghost occupation number) and the commutators
  `ghostNumber_comm_ghostCre`, `ghostNumber_comm_ghostAnn`.
* **The cubic ghost charge is nilpotent** — `smGhostCharge_nilpotent`, through the project's
  `BookProof.BRSTNilpotent.brst_charge_nilpotent` with the Standard-Model structure
  constants.
* **The full BRST charge is nilpotent** — `brstCharge_nilpotent`, an algebraic theorem in
  any ring carrying ghosts with the CAR and constraint operators `G_a` that commute with
  the ghosts and close with the structure constants: `Ω² = 0`.
* **Second quantization is a Lie-algebra homomorphism** — `fermiBilin_lie`,
  `creat_annih_commutator`: `[dΓ(A), dΓ(B)] = dΓ([A,B])`, so the Gauss-law generators
  `G_a = −i dΓ(T_a)` of the matter sector close with the *real* structure constants
  (`matterGen_lie`), and they commute with the ghosts (`matterGen_comm_ghostCre`,
  `matterGen_comm_ghostAnn`) because they are even.
* **The Standard-Model BRST charge** `smBrstCharge` on the joint matter ⊗ ghost Fock space,
  with **`smBrstCharge_nilpotent`**: `Ω² = 0`, which is what makes the BRST cohomology —
  the physical sector — well defined.

## Honest boundary

The mode set here is finite: one plane-wave matter multiplet and the twelve ghosts, i.e. the
gauge algebra of the collective-coordinate presentation of §D6b-SM.1.  The charge used in
this module is the abstract one, with the constraints `G_a` given as data.  The BRST charge
**as `book.tex` itself defines it** — the density
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc}A_{μb}ψ†_c − (i/2) f_{abc}ψ†_aψ†_bψ_c` with the book's
canonical relations, the Gauss law *derived* from them, and the gauge-fixing fermion
`Ψ = i ψ_a A_{0a}` — is built in `BookProof.ChapterBookBrstYangMills`,
`BookProof.ChapterBookBrstGaugeFixing` and `BookProof.ChapterBookBrstInstances`, the last of
which instantiates it with the Standard-Model structure constants `smStruct f₃`.  The
`su(3)` structure constants enter as a family satisfying antisymmetry and Jacobi (which
`BookProof.ChapterYangMillsSU3` derives for trace-orthonormal generators); the book's
formalism uses no Faddeev–Popov determinant and none is constructed, and no statement about
the *size* of the BRST cohomology is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmBrstGhost

open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

/-! ## 1. The structure constants of `su(3) ⊕ su(2) ⊕ u(1)` -/

/-- The direct sum of two families of structure constants: a bracket never leaves its
summand. -/
def sumStruct {ι κ : Type*} (f1 : ι → ι → ι → ℝ) (f2 : κ → κ → κ → ℝ) :
    (ι ⊕ κ) → (ι ⊕ κ) → (ι ⊕ κ) → ℝ
  | Sum.inl a, Sum.inl b, Sum.inl c => f1 a b c
  | Sum.inr a, Sum.inr b, Sum.inr c => f2 a b c
  | _, _, _ => 0

theorem sumStruct_antisymm {ι κ : Type*} {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ} (h1 : ∀ a b c, f1 a b c = -f1 b a c)
    (h2 : ∀ a b c, f2 a b c = -f2 b a c) (a b c : ι ⊕ κ) :
    sumStruct f1 f2 a b c = -sumStruct f1 f2 b a c := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;>
    simp only [sumStruct, neg_zero] <;> first | rfl | exact h1 a b c | exact h2 a b c

theorem sumStruct_jacobi {ι κ : Type*} [Fintype ι] [Fintype κ] {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ}
    (h1 : ∀ a b c h : ι, ∑ e, (f1 a b e * f1 e c h + f1 b c e * f1 e a h
      + f1 c a e * f1 e b h) = 0)
    (h2 : ∀ a b c h : κ, ∑ e, (f2 a b e * f2 e c h + f2 b c e * f2 e a h
      + f2 c a e * f2 e b h) = 0)
    (a b c h : ι ⊕ κ) :
    ∑ e, (sumStruct f1 f2 a b e * sumStruct f1 f2 e c h
      + sumStruct f1 f2 b c e * sumStruct f1 f2 e a h
      + sumStruct f1 f2 c a e * sumStruct f1 f2 e b h) = 0 := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;> rcases h with h | h <;>
    simp only [Fintype.sum_sum_type, sumStruct, mul_zero, zero_mul, add_zero, zero_add,
      Finset.sum_const_zero] <;>
    first | rfl | exact h1 a b c h | exact h2 a b c h

/-- The Levi-Civita symbol on three indices, as an integer. -/
def epsZ (a b c : Fin 3) : ℤ :=
  if a = b ∨ b = c ∨ a = c then 0
  else if (a, b) = ((0 : Fin 3), (1 : Fin 3)) ∨ (a, b) = ((1 : Fin 3), (2 : Fin 3))
        ∨ (a, b) = ((2 : Fin 3), (0 : Fin 3)) then 1 else -1

/-- **The `su(2)` structure constants** `ε_{jkl}`. -/
def su2Struct (a b c : Fin 3) : ℝ := (epsZ a b c : ℝ)

/-- **The `u(1)` structure constants**: an abelian factor has none. -/
def u1Struct (_ _ _ : Fin 1) : ℝ := 0

theorem epsZ_antisymm : ∀ a b c : Fin 3, epsZ a b c = -epsZ b a c := by decide

theorem epsZ_jacobi : ∀ a b c h : Fin 3,
    ∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h + epsZ c a e * epsZ e b h) = 0 := by
  decide



theorem su2Struct_jacobi (a b c h : Fin 3) :
    ∑ e, (su2Struct a b e * su2Struct e c h + su2Struct b c e * su2Struct e a h
      + su2Struct c a e * su2Struct e b h) = 0 := by
  have hz := epsZ_jacobi a b c h
  have : ((∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h
      + epsZ c a e * epsZ e b h) : ℤ) : ℝ) = 0 := by rw [hz]; norm_num
  rw [← this]
  push_cast [su2Struct]
  ring





/-- The twelve generator labels of the Standard-Model gauge algebra, split into the eight
gluon, three weak and one hypercharge directions. -/
def smIdxEquiv : Fin 12 ≃ (Fin 8 ⊕ (Fin 3 ⊕ Fin 1)) :=
  (finCongr (by norm_num : (12 : ℕ) = 8 + (3 + 1))).trans
    (finSumFinEquiv.symm.trans (Equiv.sumCongr (Equiv.refl (Fin 8)) finSumFinEquiv.symm))

/-- **The structure constants of the Standard-Model gauge algebra** `su(3) ⊕ su(2) ⊕ u(1)`,
given those of `su(3)`. -/
def smStruct (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) (a b c : Fin 12) : ℝ :=
  sumStruct f3 (sumStruct su2Struct u1Struct) (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c)





/-! ## 2. The ghost sector inside the CAR algebra -/

variable {m : ℕ}

/-- The mode carrying the `a`-th ghost: the ghosts are the last twelve modes of the
fermionic Fock space, the matter modes being the first `m`. -/
def ghostMode (m : ℕ) (a : Fin 12) : Fin (m + 12) := Fin.natAdd m a

/-- The **ghost creation** operator `c^a`. -/
def ghostCre (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  creat (ghostMode m a)

/-- The **ghost annihilation** (antighost) operator `b_a`. -/
def ghostAnn (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  annih (ghostMode m a)





/-- **The ghost-number operator** `Σ_a c^a b_a`. -/
def ghostNumber (m : ℕ) : Module.End ℂ (FermiFock (m + 12)) :=
  ∑ a : Fin 12, ghostCre m a * ghostAnn m a













t/BRST sector is not built”*.  The Grassmann
coordinates `ζ_F` of §D6b-SM.1 carry, besides the matter fermions, **one ghost per gauge
generator**; the Standard-Model gauge algebra `su(3) ⊕ su(2) ⊕ u(1)` has `8 + 3 + 1 = 12`
generators, so the ghost sector is a twelve-mode CAR algebra, and the BRST charge is

```
Ω = Σ_a c^a G_a − ½ Σ_{a,b,c} f_{abc} c^a c^b b_c .
```

## What is proved

* **The structure constants of the Standard-Model gauge algebra.**  `sumStruct` is the
  direct sum of two structure-constant families, `sumStruct_antisymm` and
  `sumStruct_jacobi` show that antisymmetry and the Jacobi identity are inherited;
  `su2Struct` is the concrete `su(2)` Levi-Civita family (antisymmetry and Jacobi by finite
  check), `u1Struct` the abelian one, and `smStruct f₃` assembles them with an `su(3)`
  family `f₃` into the twelve-generator family, with **`smStruct_antisymm`** and
  **`smStruct_jacobi`**: the Standard-Model gauge algebra has totally antisymmetric
  structure constants obeying Jacobi, which is exactly what BRST needs.
* **The ghost sector on the CAR algebra.**  The ghosts are the last twelve modes of the
  fermionic Fock space of `BookProof.ChapterSmCarAlgebra`; `smGhostCAR` is their canonical
  anticommutation relations, `ghostNumber` the ghost-number operator with
  `ghostNumber_occ` (its spectrum is the ghost occupation number) and the commutators
  `ghostNumber_comm_ghostCre`, `ghostNumber_comm_ghostAnn`.
* **The cubic ghost charge is nilpotent** — `smGhostCharge_nilpotent`, through the project's
  `BookProof.BRSTNilpotent.brst_charge_nilpotent` with the Standard-Model structure
  constants.
* **The full BRST charge is nilpotent** — `brstCharge_nilpotent`, an algebraic theorem in
  any ring carrying ghosts with the CAR and constraint operators `G_a` that commute with
  the ghosts and close with the structure constants: `Ω² = 0`.
* **Second quantization is a Lie-algebra homomorphism** — `fermiBilin_lie`,
  `creat_annih_commutator`: `[dΓ(A), dΓ(B)] = dΓ([A,B])`, so the Gauss-law generators
  `G_a = −i dΓ(T_a)` of the matter sector close with the *real* structure constants
  (`matterGen_lie`), and they commute with the ghosts (`matterGen_comm_ghostCre`,
  `matterGen_comm_ghostAnn`) because they are even.
* **The Standard-Model BRST charge** `smBrstCharge` on the joint matter ⊗ ghost Fock space,
  with **`smBrstCharge_nilpotent`**: `Ω² = 0`, which is what makes the BRST cohomology —
  the physical sector — well defined.

## Honest boundary

The mode set here is finite: one plane-wave matter multiplet and the twelve ghosts, i.e. the
gauge algebra of the collective-coordinate presentation of §D6b-SM.1.  The charge used in
this module is the abstract one, with the constraints `G_a` given as data.  The BRST charge
**as `book.tex` itself defines it** — the density
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc}A_{μb}ψ†_c − (i/2) f_{abc}ψ†_aψ†_bψ_c` with the book's
canonical relations, the Gauss law *derived* from them, and the gauge-fixing fermion
`Ψ = i ψ_a A_{0a}` — is built in `BookProof.ChapterBookBrstYangMills`,
`BookProof.ChapterBookBrstGaugeFixing` and `BookProof.ChapterBookBrstInstances`, the last of
which instantiates it with the Standard-Model structure constants `smStruct f₃`.  The
`su(3)` structure constants enter as a family satisfying antisymmetry and Jacobi (which
`BookProof.ChapterYangMillsSU3` derives for trace-orthonormal generators); the book's
formalism uses no Faddeev–Popov determinant and none is constructed, and no statement about
the *size* of the BRST cohomology is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmBrstGhost

open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

/-! ## 1. The structure constants of `su(3) ⊕ su(2) ⊕ u(1)` -/

/-- The direct sum of two families of structure constants: a bracket never leaves its
summand. -/
def sumStruct {ι κ : Type*} (f1 : ι → ι → ι → ℝ) (f2 : κ → κ → κ → ℝ) :
    (ι ⊕ κ) → (ι ⊕ κ) → (ι ⊕ κ) → ℝ
  | Sum.inl a, Sum.inl b, Sum.inl c => f1 a b c
  | Sum.inr a, Sum.inr b, Sum.inr c => f2 a b c
  | _, _, _ => 0

theorem sumStruct_antisymm {ι κ : Type*} {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ} (h1 : ∀ a b c, f1 a b c = -f1 b a c)
    (h2 : ∀ a b c, f2 a b c = -f2 b a c) (a b c : ι ⊕ κ) :
    sumStruct f1 f2 a b c = -sumStruct f1 f2 b a c := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;>
    simp only [sumStruct, neg_zero] <;> first | rfl | exact h1 a b c | exact h2 a b c

theorem sumStruct_jacobi {ι κ : Type*} [Fintype ι] [Fintype κ] {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ}
    (h1 : ∀ a b c h : ι, ∑ e, (f1 a b e * f1 e c h + f1 b c e * f1 e a h
      + f1 c a e * f1 e b h) = 0)
    (h2 : ∀ a b c h : κ, ∑ e, (f2 a b e * f2 e c h + f2 b c e * f2 e a h
      + f2 c a e * f2 e b h) = 0)
    (a b c h : ι ⊕ κ) :
    ∑ e, (sumStruct f1 f2 a b e * sumStruct f1 f2 e c h
      + sumStruct f1 f2 b c e * sumStruct f1 f2 e a h
      + sumStruct f1 f2 c a e * sumStruct f1 f2 e b h) = 0 := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;> rcases h with h | h <;>
    simp only [Fintype.sum_sum_type, sumStruct, mul_zero, zero_mul, add_zero, zero_add,
      Finset.sum_const_zero] <;>
    first | rfl | exact h1 a b c h | exact h2 a b c h

/-- The Levi-Civita symbol on three indices, as an integer. -/
def epsZ (a b c : Fin 3) : ℤ :=
  if a = b ∨ b = c ∨ a = c then 0
  else if (a, b) = ((0 : Fin 3), (1 : Fin 3)) ∨ (a, b) = ((1 : Fin 3), (2 : Fin 3))
        ∨ (a, b) = ((2 : Fin 3), (0 : Fin 3)) then 1 else -1

/-- **The `su(2)` structure constants** `ε_{jkl}`. -/
def su2Struct (a b c : Fin 3) : ℝ := (epsZ a b c : ℝ)

/-- **The `u(1)` structure constants**: an abelian factor has none. -/
def u1Struct (_ _ _ : Fin 1) : ℝ := 0

theorem epsZ_antisymm : ∀ a b c : Fin 3, epsZ a b c = -epsZ b a c := by decide

theorem epsZ_jacobi : ∀ a b c h : Fin 3,
    ∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h + epsZ c a e * epsZ e b h) = 0 := by
  decide

theorem su2Struct_antisymm (a b c : Fin 3) : su2Struct a b c = -su2Struct b a c := by
  rw [su2Struct, su2Struct, epsZ_antisymm a b c]
  push_cast
  ring

theorem su2Struct_jacobi (a b c h : Fin 3) :
    ∑ e, (su2Struct a b e * su2Struct e c h + su2Struct b c e * su2Struct e a h
      + su2Struct c a e * su2Struct e b h) = 0 := by
  have hz := epsZ_jacobi a b c h
  have : ((∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h
      + epsZ c a e * epsZ e b h) : ℤ) : ℝ) = 0 := by rw [hz]; norm_num
  rw [← this]
  push_cast [su2Struct]
  ring

theorem u1Struct_antisymm (a b c : Fin 1) : u1Struct a b c = -u1Struct b a c := by
  simp [u1Struct]

theorem u1Struct_jacobi (a b c h : Fin 1) :
    ∑ e, (u1Struct a b e * u1Struct e c h + u1Struct b c e * u1Struct e a h
      + u1Struct c a e * u1Struct e b h) = 0 := by
  simp [u1Struct]

/-- The twelve generator labels of the Standard-Model gauge algebra, split into the eight
gluon, three weak and one hypercharge directions. -/
def smIdxEquiv : Fin 12 ≃ (Fin 8 ⊕ (Fin 3 ⊕ Fin 1)) :=
  (finCongr (by norm_num : (12 : ℕ) = 8 + (3 + 1))).trans
    (finSumFinEquiv.symm.trans (Equiv.sumCongr (Equiv.refl (Fin 8)) finSumFinEquiv.symm))

/-- **The structure constants of the Standard-Model gauge algebra** `su(3) ⊕ su(2) ⊕ u(1)`,
given those of `su(3)`. -/
def smStruct (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) (a b c : Fin 12) : ℝ :=
  sumStruct f3 (sumStruct su2Struct u1Struct) (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c)

theorem smStruct_antisymm {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c, f3 a b c = -f3 b a c) (a b c : Fin 12) :
    smStruct f3 a b c = -smStruct f3 b a c := by
  exact sumStruct_antisymm h3
    (sumStruct_antisymm su2Struct_antisymm u1Struct_antisymm) _ _ _

theorem smStruct_jacobi {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) (a b c h : Fin 12) :
    ∑ e, (smStruct f3 a b e * smStruct f3 e c h + smStruct f3 b c e * smStruct f3 e a h
      + smStruct f3 c a e * smStruct f3 e b h) = 0 := by
  have hsum := sumStruct_jacobi (f1 := f3) (f2 := sumStruct su2Struct u1Struct) h3
    (sumStruct_jacobi su2Struct_jacobi u1Struct_jacobi)
    (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c) (smIdxEquiv h)
  rw [← Equiv.sum_comp smIdxEquiv] at hsum
  simpa [smStruct] using hsum

/-! ## 2. The ghost sector inside the CAR algebra -/

variable {m : ℕ}

/-- The mode carrying the `a`-th ghost: the ghosts are the last twelve modes of the
fermionic Fock space, the matter modes being the first `m`. -/
def ghostMode (m : ℕ) (a : Fin 12) : Fin (m + 12) := Fin.natAdd m a

/-- The **ghost creation** operator `c^a`. -/
def ghostCre (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  creat (ghostMode m a)

/-- The **ghost annihilation** (antighost) operator `b_a`. -/
def ghostAnn (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  annih (ghostMode m a)

/-- **The ghosts obey the canonical anticommutation relations.** -/
theorem ghostMode_injective (m : ℕ) : Function.Injective (ghostMode m) := by
  intro a b hab
  have h : m + (a : ℕ) = m + (b : ℕ) := by
    simpa [ghostMode, Fin.ext_iff] using hab
  exact Fin.ext (by omega)

theorem smGhostCAR (m : ℕ) : GhostCAR (ghostCre m) (ghostAnn m) := by
  refine ⟨fun a b => ?_, fun a b => ?_, fun a b => ?_⟩
  · exact car_creat_creat (ghostMode m a) (ghostMode m b)
  · exact car_annih_annih (ghostMode m a) (ghostMode m b)
  · by_cases h : a = b
    · subst h
      rw [if_pos rfl]
      exact car_annih_creat_self (ghostMode m a)
    · rw [if_neg h]
      exact car_annih_creat_of_ne (fun hh => h (ghostMode_injective m hh))

/-- **The ghost-number operator** `Σ_a c^a b_a`. -/
def ghostNumber (m : ℕ) : Module.End ℂ (FermiFock (m + 12)) :=
  ∑ a : Fin 12, ghostCre m a * ghostAnn m a

/-- The mixed canonical anticommutation relation in ring form. -/
theorem annih_mul_creat {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * creat q
      = (if p = q then 1 else 0) - creat q * annih p := by
  by_cases h : p = q
  · subst h
    rw [if_pos rfl]
    exact eq_sub_of_add_eq (car_annih_creat_self p)
  · rw [if_neg h]
    exact eq_sub_of_add_eq (car_annih_creat_of_ne h)

/-- Creation operators anticommute, in ring form. -/
theorem creat_mul_creat {N : ℕ} (p q : Fin N) :
    (creat p : Module.End ℂ (FermiFock N)) * creat q = -(creat q * creat p) :=
  eq_neg_of_add_eq_zero_left (car_creat_creat p q)

/-- Annihilation operators anticommute, in ring form. -/
theorem annih_mul_annih {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * annih q = -(annih q * annih p) :=
  eq_neg_of_add_eq_zero_left (car_annih_annih p q)

/-- The occupation-number operator of a mode on an occupation state. -/
theorem occupation_occ {N : ℕ} (i : Fin N) (S : Finset (Fin N)) :
    creat i (annih i (occ S)) = if i ∈ S then occ S else 0 := by
  ext T
  rw [occupation_apply]
  by_cases h : i ∈ S <;> by_cases hT : T = S <;>
    simp [h, hT, occ, EuclideanSpace.single_apply]

/-- **The ghost number of an occupation state** is the number of occupied ghost modes. -/
theorem ghostNumber_occ (m : ℕ) (S : Finset (Fin (m + 12))) :
    ghostNumber m (occ S)
      = (Finset.univ.filter (fun a : Fin 12 => ghostMode m a ∈ S)).card • occ S := by
  classical
  rw [ghostNumber, LinearMap.sum_apply]
  have hterm : ∀ a : Fin 12, (ghostCre m a * ghostAnn m a) (occ S)
      = if ghostMode m a ∈ S then occ S else 0 := fun a => occupation_occ (ghostMode m a) S
  rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hterm a]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero]

/-- Creation operators square to zero (the Pauli principle). -/
theorem creat_sq {N : ℕ} (i : Fin N) :
    (creat i : Module.End ℂ (FermiFock N)) * creat i = 0 := by
  have h2 : (2 : ℂ) • ((creat i : Module.End ℂ (FermiFock N)) * creat i) = 0 := by
    rw [two_smul]; exact car_creat_creat i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- Annihilation operators square to zero. -/
theorem annih_sq {N : ℕ} (i : Fin N) :
    (annih i : Module.End ℂ (FermiFock N)) * annih i = 0 := by
  have h2 : (2 : ℂ) • ((annih i : Module.End ℂ (FermiFock N)) * annih i) = 0 := by
    rw [two_smul]; exact car_annih_annih i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- A ghost creation operator raises the ghost number by one. -/
theorem ghostNumber_comm_ghostCre (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostCre m a - ghostCre m a * ghostNumber m = ghostCre m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * (1 - ghostCre m a * ghostAnn m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by rw [hAC]
      _ = ghostCre m a := by
            have hsq : (ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a = 0 := by
              rw [ghostCre]; exact creat_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (1 - ghostCre m a * ghostAnn m a)
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a
                = ghostCre m a - (ghostCre m a * ghostCre m a) * ghostAnn m a
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
              _ = ghostCre m a := by rw [hsq]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostAnn m b) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg hne, zero_sub]
    have hCC : (ghostCre m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostCre m b) := by
      rw [ghostCre, ghostCre, creat_mul_creat]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = ghostCre m b * -(ghostCre m a * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hAC]
      _ = -((ghostCre m b * ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = -((-(ghostCre m a * ghostCre m b) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hCC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha



/-- **The cubic ghost part of the Standard-Model BRST charge.** -/
def smGhostCharge (m : ℕ) (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    Module.End ℂ (FermiFock (m + 12)) :=
  Q (smStruct f3) (ghostCre m) (ghostAnn m)



/-! ## 3. The full BRST charge, in the abstract -/

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}





/-- **The BRST charge** `Ω = Σ_a c^a G_a − ½ f_{abc} c^a c^b b_c` of a family of first-class
constraints `G_a`. -/
def brstCharge (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R) (G : Fin n → R) : R :=
  (∑ a, χ a * G a) - (1 / 2 : ℝ) • Q f χ β



/-! ## 4. The Gauss-law constraints: second quantization as a Lie homomorphism -/

variable {N : ℕ}















.**  `sumStruct` is the
  direct sum of two structure-constant families, `sumStruct_antisymm` and
  `sumStruct_jacobi` show that antisymmetry and the Jacobi identity are inherited;
  `su2Struct` is the concrete `su(2)` Levi-Civita family (antisymmetry and Jacobi by finite
  check), `u1Struct` the abelian one, and `smStruct f₃` assembles them with an `su(3)`
  family `f₃` into the twelve-generator family, with **`smStruct_antisymm`** and
  **`smStruct_jacobi`**: the Standard-Model gauge algebra has totally antisymmetric
  structure constants obeying Jacobi, which is exactly what BRST needs.
* **The ghost sector on the CAR algebra.**  The ghosts are the last twelve modes of the
  fermionic Fock space of `BookProof.ChapterSmCarAlgebra`; `smGhostCAR` is their canonical
  anticommutation relations, `ghostNumber` the ghost-number operator with
  `ghostNumber_occ` (its spectrum is the ghost occupation number) and the commutators
  `ghostNumber_comm_ghostCre`, `ghostNumber_comm_ghostAnn`.
* **The cubic ghost charge is nilpotent** — `smGhostCharge_nilpotent`, through the project's
  `BookProof.BRSTNilpotent.brst_charge_nilpotent` with the Standard-Model structure
  constants.
* **The full BRST charge is nilpotent** — `brstCharge_nilpotent`, an algebraic theorem in
  any ring carrying ghosts with the CAR and constraint operators `G_a` that commute with
  the ghosts and close with the structure constants: `Ω² = 0`.
* **Second quantization is a Lie-algebra homomorphism** — `fermiBilin_lie`,
  `creat_annih_commutator`: `[dΓ(A), dΓ(B)] = dΓ([A,B])`, so the Gauss-law generators
  `G_a = −i dΓ(T_a)` of the matter sector close with the *real* structure constants
  (`matterGen_lie`), and they commute with the ghosts (`matterGen_comm_ghostCre`,
  `matterGen_comm_ghostAnn`) because they are even.
* **The Standard-Model BRST charge** `smBrstCharge` on the joint matter ⊗ ghost Fock space,
  with **`smBrstCharge_nilpotent`**: `Ω² = 0`, which is what makes the BRST cohomology —
  the physical sector — well defined.

## Honest boundary

The mode set here is finite: one plane-wave matter multiplet and the twelve ghosts, i.e. the
gauge algebra of the collective-coordinate presentation of §D6b-SM.1.  The charge used in
this module is the abstract one, with the constraints `G_a` given as data.  The BRST charge
**as `book.tex` itself defines it** — the density
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc}A_{μb}ψ†_c − (i/2) f_{abc}ψ†_aψ†_bψ_c` with the book's
canonical relations, the Gauss law *derived* from them, and the gauge-fixing fermion
`Ψ = i ψ_a A_{0a}` — is built in `BookProof.ChapterBookBrstYangMills`,
`BookProof.ChapterBookBrstGaugeFixing` and `BookProof.ChapterBookBrstInstances`, the last of
which instantiates it with the Standard-Model structure constants `smStruct f₃`.  The
`su(3)` structure constants enter as a family satisfying antisymmetry and Jacobi (which
`BookProof.ChapterYangMillsSU3` derives for trace-orthonormal generators); the book's
formalism uses no Faddeev–Popov determinant and none is constructed, and no statement about
the *size* of the BRST cohomology is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmBrstGhost

open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

/-! ## 1. The structure constants of `su(3) ⊕ su(2) ⊕ u(1)` -/

/-- The direct sum of two families of structure constants: a bracket never leaves its
summand. -/
def sumStruct {ι κ : Type*} (f1 : ι → ι → ι → ℝ) (f2 : κ → κ → κ → ℝ) :
    (ι ⊕ κ) → (ι ⊕ κ) → (ι ⊕ κ) → ℝ
  | Sum.inl a, Sum.inl b, Sum.inl c => f1 a b c
  | Sum.inr a, Sum.inr b, Sum.inr c => f2 a b c
  | _, _, _ => 0

theorem sumStruct_antisymm {ι κ : Type*} {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ} (h1 : ∀ a b c, f1 a b c = -f1 b a c)
    (h2 : ∀ a b c, f2 a b c = -f2 b a c) (a b c : ι ⊕ κ) :
    sumStruct f1 f2 a b c = -sumStruct f1 f2 b a c := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;>
    simp only [sumStruct, neg_zero] <;> first | rfl | exact h1 a b c | exact h2 a b c

theorem sumStruct_jacobi {ι κ : Type*} [Fintype ι] [Fintype κ] {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ}
    (h1 : ∀ a b c h : ι, ∑ e, (f1 a b e * f1 e c h + f1 b c e * f1 e a h
      + f1 c a e * f1 e b h) = 0)
    (h2 : ∀ a b c h : κ, ∑ e, (f2 a b e * f2 e c h + f2 b c e * f2 e a h
      + f2 c a e * f2 e b h) = 0)
    (a b c h : ι ⊕ κ) :
    ∑ e, (sumStruct f1 f2 a b e * sumStruct f1 f2 e c h
      + sumStruct f1 f2 b c e * sumStruct f1 f2 e a h
      + sumStruct f1 f2 c a e * sumStruct f1 f2 e b h) = 0 := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;> rcases h with h | h <;>
    simp only [Fintype.sum_sum_type, sumStruct, mul_zero, zero_mul, add_zero, zero_add,
      Finset.sum_const_zero] <;>
    first | rfl | exact h1 a b c h | exact h2 a b c h

/-- The Levi-Civita symbol on three indices, as an integer. -/
def epsZ (a b c : Fin 3) : ℤ :=
  if a = b ∨ b = c ∨ a = c then 0
  else if (a, b) = ((0 : Fin 3), (1 : Fin 3)) ∨ (a, b) = ((1 : Fin 3), (2 : Fin 3))
        ∨ (a, b) = ((2 : Fin 3), (0 : Fin 3)) then 1 else -1

/-- **The `su(2)` structure constants** `ε_{jkl}`. -/
def su2Struct (a b c : Fin 3) : ℝ := (epsZ a b c : ℝ)

/-- **The `u(1)` structure constants**: an abelian factor has none. -/
def u1Struct (_ _ _ : Fin 1) : ℝ := 0

theorem epsZ_antisymm : ∀ a b c : Fin 3, epsZ a b c = -epsZ b a c := by decide

theorem epsZ_jacobi : ∀ a b c h : Fin 3,
    ∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h + epsZ c a e * epsZ e b h) = 0 := by
  decide

theorem su2Struct_antisymm (a b c : Fin 3) : su2Struct a b c = -su2Struct b a c := by
  rw [su2Struct, su2Struct, epsZ_antisymm a b c]
  push_cast
  ring

theorem su2Struct_jacobi (a b c h : Fin 3) :
    ∑ e, (su2Struct a b e * su2Struct e c h + su2Struct b c e * su2Struct e a h
      + su2Struct c a e * su2Struct e b h) = 0 := by
  have hz := epsZ_jacobi a b c h
  have : ((∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h
      + epsZ c a e * epsZ e b h) : ℤ) : ℝ) = 0 := by rw [hz]; norm_num
  rw [← this]
  push_cast [su2Struct]
  ring

theorem u1Struct_antisymm (a b c : Fin 1) : u1Struct a b c = -u1Struct b a c := by
  simp [u1Struct]

theorem u1Struct_jacobi (a b c h : Fin 1) :
    ∑ e, (u1Struct a b e * u1Struct e c h + u1Struct b c e * u1Struct e a h
      + u1Struct c a e * u1Struct e b h) = 0 := by
  simp [u1Struct]

/-- The twelve generator labels of the Standard-Model gauge algebra, split into the eight
gluon, three weak and one hypercharge directions. -/
def smIdxEquiv : Fin 12 ≃ (Fin 8 ⊕ (Fin 3 ⊕ Fin 1)) :=
  (finCongr (by norm_num : (12 : ℕ) = 8 + (3 + 1))).trans
    (finSumFinEquiv.symm.trans (Equiv.sumCongr (Equiv.refl (Fin 8)) finSumFinEquiv.symm))

/-- **The structure constants of the Standard-Model gauge algebra** `su(3) ⊕ su(2) ⊕ u(1)`,
given those of `su(3)`. -/
def smStruct (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) (a b c : Fin 12) : ℝ :=
  sumStruct f3 (sumStruct su2Struct u1Struct) (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c)

theorem smStruct_antisymm {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c, f3 a b c = -f3 b a c) (a b c : Fin 12) :
    smStruct f3 a b c = -smStruct f3 b a c := by
  exact sumStruct_antisymm h3
    (sumStruct_antisymm su2Struct_antisymm u1Struct_antisymm) _ _ _

theorem smStruct_jacobi {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) (a b c h : Fin 12) :
    ∑ e, (smStruct f3 a b e * smStruct f3 e c h + smStruct f3 b c e * smStruct f3 e a h
      + smStruct f3 c a e * smStruct f3 e b h) = 0 := by
  have hsum := sumStruct_jacobi (f1 := f3) (f2 := sumStruct su2Struct u1Struct) h3
    (sumStruct_jacobi su2Struct_jacobi u1Struct_jacobi)
    (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c) (smIdxEquiv h)
  rw [← Equiv.sum_comp smIdxEquiv] at hsum
  simpa [smStruct] using hsum

/-! ## 2. The ghost sector inside the CAR algebra -/

variable {m : ℕ}

/-- The mode carrying the `a`-th ghost: the ghosts are the last twelve modes of the
fermionic Fock space, the matter modes being the first `m`. -/
def ghostMode (m : ℕ) (a : Fin 12) : Fin (m + 12) := Fin.natAdd m a

/-- The **ghost creation** operator `c^a`. -/
def ghostCre (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  creat (ghostMode m a)

/-- The **ghost annihilation** (antighost) operator `b_a`. -/
def ghostAnn (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  annih (ghostMode m a)

/-- **The ghosts obey the canonical anticommutation relations.** -/
theorem ghostMode_injective (m : ℕ) : Function.Injective (ghostMode m) := by
  intro a b hab
  have h : m + (a : ℕ) = m + (b : ℕ) := by
    simpa [ghostMode, Fin.ext_iff] using hab
  exact Fin.ext (by omega)

theorem smGhostCAR (m : ℕ) : GhostCAR (ghostCre m) (ghostAnn m) := by
  refine ⟨fun a b => ?_, fun a b => ?_, fun a b => ?_⟩
  · exact car_creat_creat (ghostMode m a) (ghostMode m b)
  · exact car_annih_annih (ghostMode m a) (ghostMode m b)
  · by_cases h : a = b
    · subst h
      rw [if_pos rfl]
      exact car_annih_creat_self (ghostMode m a)
    · rw [if_neg h]
      exact car_annih_creat_of_ne (fun hh => h (ghostMode_injective m hh))

/-- **The ghost-number operator** `Σ_a c^a b_a`. -/
def ghostNumber (m : ℕ) : Module.End ℂ (FermiFock (m + 12)) :=
  ∑ a : Fin 12, ghostCre m a * ghostAnn m a

/-- The mixed canonical anticommutation relation in ring form. -/
theorem annih_mul_creat {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * creat q
      = (if p = q then 1 else 0) - creat q * annih p := by
  by_cases h : p = q
  · subst h
    rw [if_pos rfl]
    exact eq_sub_of_add_eq (car_annih_creat_self p)
  · rw [if_neg h]
    exact eq_sub_of_add_eq (car_annih_creat_of_ne h)

/-- Creation operators anticommute, in ring form. -/
theorem creat_mul_creat {N : ℕ} (p q : Fin N) :
    (creat p : Module.End ℂ (FermiFock N)) * creat q = -(creat q * creat p) :=
  eq_neg_of_add_eq_zero_left (car_creat_creat p q)

/-- Annihilation operators anticommute, in ring form. -/
theorem annih_mul_annih {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * annih q = -(annih q * annih p) :=
  eq_neg_of_add_eq_zero_left (car_annih_annih p q)

/-- The occupation-number operator of a mode on an occupation state. -/
theorem occupation_occ {N : ℕ} (i : Fin N) (S : Finset (Fin N)) :
    creat i (annih i (occ S)) = if i ∈ S then occ S else 0 := by
  ext T
  rw [occupation_apply]
  by_cases h : i ∈ S <;> by_cases hT : T = S <;>
    simp [h, hT, occ, EuclideanSpace.single_apply]

/-- **The ghost number of an occupation state** is the number of occupied ghost modes. -/
theorem ghostNumber_occ (m : ℕ) (S : Finset (Fin (m + 12))) :
    ghostNumber m (occ S)
      = (Finset.univ.filter (fun a : Fin 12 => ghostMode m a ∈ S)).card • occ S := by
  classical
  rw [ghostNumber, LinearMap.sum_apply]
  have hterm : ∀ a : Fin 12, (ghostCre m a * ghostAnn m a) (occ S)
      = if ghostMode m a ∈ S then occ S else 0 := fun a => occupation_occ (ghostMode m a) S
  rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hterm a]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero]

/-- Creation operators square to zero (the Pauli principle). -/
theorem creat_sq {N : ℕ} (i : Fin N) :
    (creat i : Module.End ℂ (FermiFock N)) * creat i = 0 := by
  have h2 : (2 : ℂ) • ((creat i : Module.End ℂ (FermiFock N)) * creat i) = 0 := by
    rw [two_smul]; exact car_creat_creat i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- Annihilation operators square to zero. -/
theorem annih_sq {N : ℕ} (i : Fin N) :
    (annih i : Module.End ℂ (FermiFock N)) * annih i = 0 := by
  have h2 : (2 : ℂ) • ((annih i : Module.End ℂ (FermiFock N)) * annih i) = 0 := by
    rw [two_smul]; exact car_annih_annih i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- A ghost creation operator raises the ghost number by one. -/
theorem ghostNumber_comm_ghostCre (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostCre m a - ghostCre m a * ghostNumber m = ghostCre m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * (1 - ghostCre m a * ghostAnn m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by rw [hAC]
      _ = ghostCre m a := by
            have hsq : (ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a = 0 := by
              rw [ghostCre]; exact creat_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (1 - ghostCre m a * ghostAnn m a)
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a
                = ghostCre m a - (ghostCre m a * ghostCre m a) * ghostAnn m a
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
              _ = ghostCre m a := by rw [hsq]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostAnn m b) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg hne, zero_sub]
    have hCC : (ghostCre m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostCre m b) := by
      rw [ghostCre, ghostCre, creat_mul_creat]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = ghostCre m b * -(ghostCre m a * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hAC]
      _ = -((ghostCre m b * ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = -((-(ghostCre m a * ghostCre m b) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hCC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha

/-- A ghost annihilation operator lowers the ghost number by one. -/
theorem ghostNumber_comm_ghostAnn (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostAnn m a - ghostAnn m a * ghostNumber m = -ghostAnn m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
          - ghostAnn m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
              * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - (1 - ghostCre m a * ghostAnn m a) * ghostAnn m a := by rw [hAC]
      _ = -ghostAnn m a := by
            have hsqA : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a = 0 := by
              rw [ghostAnn]; exact annih_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (ghostAnn m a * ghostAnn m a)
                  - (1 - ghostCre m a * ghostAnn m a) * ghostAnn m a
                = ghostCre m a * (ghostAnn m a * ghostAnn m a) - ghostAnn m a
                  + ghostCre m a * (ghostAnn m a * ghostAnn m a) := by noncomm_ring
              _ = -ghostAnn m a := by rw [hsqA]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m b
        = -(ghostCre m b * ghostAnn m a) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg (fun hh => hne hh.symm), zero_sub]
    have hAA : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
        = -(ghostAnn m a * ghostAnn m b) := by
      rw [ghostAnn, ghostAnn, annih_mul_annih]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
          - ghostAnn m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m b)
              * ghostAnn m b := by noncomm_ring
      _ = ghostCre m b * -((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - (-(ghostCre m b * ghostAnn m a) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b := by rw [hAA, hAC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha

/-- **The cubic ghost part of the Standard-Model BRST charge.** -/
def smGhostCharge (m : ℕ) (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    Module.End ℂ (FermiFock (m + 12)) :=
  Q (smStruct f3) (ghostCre m) (ghostAnn m)

/-- **The cubic ghost charge of the Standard Model is nilpotent.** -/
theorem smGhostCharge_nilpotent (m : ℕ) {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3anti : ∀ a b c, f3 a b c = -f3 b a c)
    (h3jac : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) :
    smGhostCharge m f3 * smGhostCharge m f3 = 0 :=
  brst_charge_nilpotent (smStruct f3) (ghostCre m) (ghostAnn m) (smGhostCAR m)
    (smStruct_antisymm h3anti) (smStruct_jacobi h3jac)

/-! ## 3. The full BRST charge, in the abstract -/

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}

/-- Rotating the innermost index of a threefold sum to the front. -/
theorem sum_rotate3 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := by
  calc ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, F a d g :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := Finset.sum_comm

/-- Rotating the innermost index of a fourfold sum to the front. -/
theorem sum_rotate4 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := by
  calc ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, ∑ h : Fin n, F a d g h :=
        Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun g _ => Finset.sum_comm
    _ = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := Finset.sum_comm

/-- **The BRST charge** `Ω = Σ_a c^a G_a − ½ f_{abc} c^a c^b b_c` of a family of first-class
constraints `G_a`. -/
def brstCharge (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R) (G : Fin n → R) : R :=
  (∑ a, χ a * G a) - (1 / 2 : ℝ) • Q f χ β

/-- **Nilpotency of the full BRST charge.**  If the ghosts obey the CAR, the constraints
commute with the ghosts and close with real structure constants that are antisymmetric and
satisfy the Jacobi identity, then `Ω² = 0` — the fact that makes the BRST cohomology, hence
the physical (gauge-invariant) sector, well defined. -/
theorem brstCharge_nilpotent (f : Fin n → Fin n → Fin n → ℝ) (χ β G : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hGχ : ∀ a b, G a * χ b = χ b * G a) (hGβ : ∀ a b, G a * β b = β b * G a)
    (hclose : ∀ a b, G a * G b - G b * G a = ∑ c, f a b c • G c)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    brstCharge f χ β G * brstCharge f χ β G = 0 := by
  classical
  -- the two halves of the charge
  set X : R := ∑ a, χ a * G a with hXdef
  -- moving a ghost creation operator through a cubic ghost monomial
  have hmove : ∀ a d g h : Fin n,
      χ a * (χ d * χ g * β h) + (χ d * χ g * β h) * χ a
        = (if h = a then (1 : R) else 0) * (χ d * χ g) := by
    intro a d g h
    have hb : β h * χ a = (if h = a then (1 : R) else 0) - χ a * β h :=
      eq_sub_of_add_eq (hCAR.betachi h a)
    have hda : χ d * χ a = -(χ a * χ d) := eq_neg_of_add_eq_zero_left (hCAR.chichi d a)
    have hga : χ g * χ a = -(χ a * χ g) := eq_neg_of_add_eq_zero_left (hCAR.chichi g a)
    have h3 : χ d * χ g * χ a = χ a * (χ d * χ g) := by
      calc χ d * χ g * χ a = χ d * (χ g * χ a) := by noncomm_ring
        _ = χ d * -(χ a * χ g) := by rw [hga]
        _ = -((χ d * χ a) * χ g) := by noncomm_ring
        _ = -((-(χ a * χ d)) * χ g) := by rw [hda]
        _ = χ a * (χ d * χ g) := by noncomm_ring
    have key : (χ d * χ g * β h) * χ a
        = (if h = a then (1 : R) else 0) * (χ d * χ g) - χ a * (χ d * χ g * β h) := by
      have h1 : (χ d * χ g * β h) * χ a = χ d * χ g * (β h * χ a) := by noncomm_ring
      rw [h1, hb]
      have h2 : χ d * χ g * ((if h = a then (1 : R) else 0) - χ a * β h)
          = (if h = a then (1 : R) else 0) * (χ d * χ g) - (χ d * χ g * χ a) * β h := by
        by_cases hh : h = a
        · simp only [hh, if_pos]; noncomm_ring
        · simp only [if_neg hh]; noncomm_ring
      rw [h2, h3]
      noncomm_ring
    rw [key]
    abel
  -- the square of the linear part
  have hXXexp : X * X = ∑ a, ∑ b, (χ a * χ b) * (G a * G b) := by
    rw [hXdef, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [show (χ a * G a) * (χ b * G b) = χ a * (G a * χ b) * G b by noncomm_ring, hGχ a b]
    noncomm_ring
  have hswap : (∑ a, ∑ b, (χ a * χ b) * (G b * G a))
      = -∑ a, ∑ b, (χ a * χ b) * (G a * G b) := by
    rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [show χ b * χ a = -(χ a * χ b) from eq_neg_of_add_eq_zero_left (hCAR.chichi b a)]
    noncomm_ring
  have hXX2 : (2 : ℝ) • (X * X) = ∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * G c) := by
    rw [two_smul, hXXexp]
    nth_rewrite 2 [show (∑ a, ∑ b, (χ a * χ b) * (G a * G b))
        = -∑ a, ∑ b, (χ a * χ b) * (G b * G a) from by rw [hswap, neg_neg]]
    rw [← sub_eq_add_neg, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← mul_sub, hclose a b, Finset.mul_sum]
    exact Finset.sum_congr rfl fun c _ => by rw [mul_smul_comm]
  -- the cross term
  have hXQ : X * Q f χ β + Q f χ β * X = ∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * G c) := by
    have hX1 : X * Q f χ β
        = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((χ a * G a) * (χ d * χ g * β h)) := by
      rw [hXdef, Q, Finset.sum_mul]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun h _ => by rw [mul_smul_comm]
    have hQ1 : Q f χ β * X
        = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((χ d * χ g * β h) * (χ a * G a)) := by
      rw [← sum_rotate4 (fun a d g h => f d g h • ((χ d * χ g * β h) * (χ a * G a)))]
      rw [hXdef, Q, Finset.sum_mul]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun h _ => ?_
      rw [smul_mul_assoc, Finset.mul_sum, Finset.smul_sum]
    rw [hX1, hQ1, ← Finset.sum_add_distrib]
    have hcollapse : ∀ a : Fin n,
        ((∑ d, ∑ g, ∑ h, f d g h • ((χ a * G a) * (χ d * χ g * β h)))
          + ∑ d, ∑ g, ∑ h, f d g h • ((χ d * χ g * β h) * (χ a * G a)))
        = ∑ d, ∑ g, f d g a • (χ d * χ g * G a) := by
      intro a
      simp only [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun d _ => ?_
      refine Finset.sum_congr rfl fun g _ => ?_
      have hterm : ∀ h : Fin n,
          f d g h • ((χ a * G a) * (χ d * χ g * β h))
            + f d g h • ((χ d * χ g * β h) * (χ a * G a))
          = f d g h • ((if h = a then (1 : R) else 0) * (χ d * χ g * G a)) := by
        intro h
        rw [← smul_add]
        congr 1
        have hc1 : (χ a * G a) * (χ d * χ g * β h) = (χ a * (χ d * χ g * β h)) * G a := by
          have hg1 : G a * (χ d * χ g * β h) = (χ d * χ g * β h) * G a := by
            rw [show G a * (χ d * χ g * β h) = ((G a * χ d) * χ g) * β h by noncomm_ring,
              hGχ a d,
              show ((χ d * G a) * χ g) * β h = (χ d * (G a * χ g)) * β h by noncomm_ring,
              hGχ a g,
              show (χ d * (χ g * G a)) * β h = (χ d * χ g) * (G a * β h) by noncomm_ring,
              hGβ a h]
            noncomm_ring
          calc (χ a * G a) * (χ d * χ g * β h)
              = χ a * (G a * (χ d * χ g * β h)) := by noncomm_ring
            _ = χ a * ((χ d * χ g * β h) * G a) := by rw [hg1]
            _ = (χ a * (χ d * χ g * β h)) * G a := by noncomm_ring
        have hc2 : (χ d * χ g * β h) * (χ a * G a)
            = ((χ d * χ g * β h) * χ a) * G a := by noncomm_ring
        rw [hc1, hc2, ← add_mul, hmove a d g h]
        noncomm_ring
      rw [Finset.sum_congr rfl fun h (_ : h ∈ Finset.univ) => hterm h]
      rw [Finset.sum_eq_single a]
      · rw [if_pos rfl, one_mul]
      · intro h _ hh
        rw [if_neg hh, zero_mul, smul_zero]
      · intro ha
        exact absurd (Finset.mem_univ a) ha
    rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hcollapse a]
    rw [← sum_rotate3 (fun a d g => f d g a • (χ d * χ g * G a))]
  -- nilpotency of the cubic ghost term
  have hQnil : Q f χ β * Q f χ β = 0 := brst_charge_nilpotent f χ β hCAR hf12 hjac
  -- assemble
  have h2 : (2 : ℝ) • (brstCharge f χ β G * brstCharge f χ β G) = 0 := by
    have hexp : brstCharge f χ β G * brstCharge f χ β G
        = X * X - (1 / 2 : ℝ) • (X * Q f χ β + Q f χ β * X)
          + (1 / 2 : ℝ) • ((1 / 2 : ℝ) • (Q f χ β * Q f χ β)) := by
      rw [brstCharge, ← hXdef]
      simp only [sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm, smul_add, smul_sub]
      abel
    have htwo : ((2 : ℝ) * (1 / 2 : ℝ)) = 1 := by norm_num
    rw [hexp, hQnil, smul_zero, smul_zero, add_zero, smul_sub, smul_smul, htwo, one_smul,
      hXX2, hXQ, sub_self]
  have hne : (2 : ℝ) ≠ 0 := two_ne_zero
  rcases smul_eq_zero.mp h2 with h | h
  · exact absurd h hne
  · exact h

/-! ## 4. The Gauss-law constraints: second quantization as a Lie homomorphism -/

variable {N : ℕ}

/-- The commutator of two occupation bilinears, from the canonical anticommutation
relations. -/
theorem creat_annih_commutator (i j k l : Fin N) :
    (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        - (creat k * annih l) * (creat i * annih j)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by
  have e1 : (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - creat i * creat k * (annih j * annih l) := by
    have h0 : (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * creat k) * annih l := by
      noncomm_ring
    rw [h0, annih_mul_creat j k]
    by_cases h : j = k
    · rw [if_pos h, if_pos h]; noncomm_ring
    · rw [if_neg h, if_neg h]; noncomm_ring
  have e2 : (creat k * annih l : Module.End ℂ (FermiFock N)) * (creat i * annih j)
      = (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
        - creat k * creat i * (annih l * annih j) := by
    have h0 : (creat k * annih l : Module.End ℂ (FermiFock N)) * (creat i * annih j)
        = creat k * ((annih l : Module.End ℂ (FermiFock N)) * creat i) * annih j := by
      noncomm_ring
    rw [h0, annih_mul_creat l i]
    by_cases h : l = i
    · rw [if_pos h, if_pos h]; noncomm_ring
    · rw [if_neg h, if_neg h]; noncomm_ring
  have e3 : (creat k * creat i : Module.End ℂ (FermiFock N)) * (annih l * annih j)
      = creat i * creat k * (annih j * annih l) := by
    rw [creat_mul_creat k i, annih_mul_annih l j]
    noncomm_ring
  rw [e1, e2, e3]
  abel

/-- The second quantization written with the ring multiplication of `Module.End`. -/
theorem fermiBilin_eq4 (M : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N))
      = ∑ i : Fin N, ∑ j : Fin N, M i j • (creat i * annih j) := rfl

theorem fermiBilin_sub (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (M - P) : Module.End ℂ (FermiFock N)) = fermiBilin M - fermiBilin P := by
  rw [fermiBilin_eq4, fermiBilin_eq4, fermiBilin_eq4, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [Matrix.sub_apply, sub_smul]

theorem fermiBilin_mul4 (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N)) * fermiBilin P
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (M i j * P k l) • ((creat i * annih j) * (creat k * annih l)) := by
  rw [fermiBilin_eq4, fermiBilin_eq4, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [smul_mul_assoc, mul_smul_comm, smul_smul]

/-- Swapping the two index pairs of a fourfold sum. -/
theorem sum4_swap (F : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N)) :
    ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
  calc ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ q : Fin N × Fin N, ∑ p : Fin N × Fin N, F p.1 p.2 q.1 q.2 := by
        simp [Fintype.sum_prod_type]
    _ = ∑ p : Fin N × Fin N, ∑ q : Fin N × Fin N, F p.1 p.2 q.1 q.2 := Finset.sum_comm
    _ = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
        simp [Fintype.sum_prod_type]

/-- The first delta contraction of the commutator sum. -/
theorem sum_delta_left (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (M * P) := by
  have step1 : ∀ i j : Fin N,
      (∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0))
        = ∑ l : Fin N, (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
    intro i j
    rw [Finset.sum_eq_single j]
    · exact Finset.sum_congr rfl fun l _ => by rw [if_pos rfl]
    · intro k _ hk
      exact Finset.sum_eq_zero fun l _ => by rw [if_neg (Ne.symm hk), smul_zero]
    · intro hj
      exact absurd (Finset.mem_univ j) hj
  calc ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ l : Fin N,
          (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => step1 i j
    _ = ∑ i : Fin N, ∑ l : Fin N, ∑ j : Fin N,
          (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ i : Fin N, ∑ l : Fin N,
          ((M * P) i l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
    _ = fermiBilin (M * P) := (fermiBilin_eq4 (M * P)).symm

/-- The second delta contraction of the commutator sum. -/
theorem sum_delta_right (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (P * M) := by
  have step1 : ∀ i j k : Fin N,
      (∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0))
        = (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
    intro i j k
    rw [Finset.sum_eq_single i]
    · rw [if_pos rfl]
    · intro l _ hl
      rw [if_neg hl, smul_zero]
    · intro hi
      exact absurd (Finset.mem_univ i) hi
  calc ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
          Finset.sum_congr rfl fun k _ => step1 i j k
    _ = ∑ i : Fin N, ∑ k : Fin N, ∑ j : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k : Fin N, ∑ i : Fin N, ∑ j : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := Finset.sum_comm
    _ = ∑ k : Fin N, ∑ j : Fin N, ∑ i : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k : Fin N, ∑ j : Fin N,
          ((P * M) k j) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
        congr 1
        exact Finset.sum_congr rfl fun i _ => by ring
    _ = fermiBilin (P * M) := (fermiBilin_eq4 (P * M)).symm

/-- **Second quantization is a Lie-algebra homomorphism**: `[dΓ(A), dΓ(B)] = dΓ([A,B])`. -/
theorem fermiBilin_lie (A B : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * fermiBilin B
        - fermiBilin B * fermiBilin A
      = fermiBilin (A * B - B * A) := by
  have h2 : (fermiBilin B : Module.End ℂ (FermiFock N)) * fermiBilin A
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (A i j * B k l) • ((creat k * annih l) * (creat i * annih j)) := by
    rw [fermiBilin_mul4 B A,
      ← sum4_swap (fun i j k l =>
        (A i j * B k l) • ((creat k * annih l : Module.End ℂ (FermiFock N))
          * (creat i * annih j)))]
    exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [mul_comm]
  rw [fermiBilin_mul4 A B, h2]
  have hcomb : ∀ X Y : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N),
      (∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, X i j k l)
        - (∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, Y i j k l)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, (X i j k l - Y i j k l) := by
    intro X Y
    simp only [← Finset.sum_sub_distrib]
  rw [hcomb]
  have hterm : ∀ i j k l : Fin N,
      ((A i j * B k l) • ((creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l))
        - (A i j * B k l) • ((creat k * annih l : Module.End ℂ (FermiFock N))
            * (creat i * annih j)))
      = (A i j * B k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (A i j * B k l)
            • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by
    intro i j k l
    rw [← smul_sub, ← smul_sub, creat_annih_commutator i j k l]
  rw [Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => Finset.sum_congr rfl
    fun j (_ : j ∈ Finset.univ) => Finset.sum_congr rfl fun k (_ : k ∈ Finset.univ) =>
      Finset.sum_congr rfl fun l (_ : l ∈ Finset.univ) => hterm i j k l]
  rw [← hcomb, sum_delta_left A B, sum_delta_right A B, ← fermiBilin_sub]



/-- A second-quantized operator whose `k`-th row vanishes commutes with the annihilation
operator of the mode `k`. -/
theorem fermiBilin_comm_annih {A : Matrix (Fin N) (Fin N) ℂ} {k : Fin N}
    (hrow : ∀ j, A k j = 0) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * annih k
      = annih k * fermiBilin A := by
  rw [fermiBilin_eq4, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases h : i = k
  · subst h
    rw [hrow j, zero_smul, zero_mul, mul_zero]
  · rw [smul_mul_assoc, mul_smul_comm]
    congr 1
    have h1 : (annih k : Module.End ℂ (FermiFock N)) * creat i = -(creat i * annih k) := by
      rw [annih_mul_creat k i, if_neg (fun hh => h hh.symm), zero_sub]
    calc (creat i * annihct sum of two structure-constant families, `sumStruct_antisymm` and
  `sumStruct_jacobi` show that antisymmetry and the Jacobi identity are inherited;
  `su2Struct` is the concrete `su(2)` Levi-Civita family (antisymmetry and Jacobi by finite
  check), `u1Struct` the abelian one, and `smStruct f₃` assembles them with an `su(3)`
  family `f₃` into the twelve-generator family, with **`smStruct_antisymm`** and
  **`smStruct_jacobi`**: the Standard-Model gauge algebra has totally antisymmetric
  structure constants obeying Jacobi, which is exactly what BRST needs.
* **The ghost sector on the CAR algebra.**  The ghosts are the last twelve modes of the
  fermionic Fock space of `BookProof.ChapterSmCarAlgebra`; `smGhostCAR` is their canonical
  anticommutation relations, `ghostNumber` the ghost-number operator with
  `ghostNumber_occ` (its spectrum is the ghost occupation number) and the commutators
  `ghostNumber_comm_ghostCre`, `ghostNumber_comm_ghostAnn`.
* **The cubic ghost charge is nilpotent** — `smGhostCharge_nilpotent`, through the project's
  `BookProof.BRSTNilpotent.brst_charge_nilpotent` with the Standard-Model structure
  constants.
* **The full BRST charge is nilpotent** — `brstCharge_nilpotent`, an algebraic theorem in
  any ring carrying ghosts with the CAR and constraint operators `G_a` that commute with
  the ghosts and close with the structure constants: `Ω² = 0`.
* **Second quantization is a Lie-algebra homomorphism** — `fermiBilin_lie`,
  `creat_annih_commutator`: `[dΓ(A), dΓ(B)] = dΓ([A,B])`, so the Gauss-law generators
  `G_a = −i dΓ(T_a)` of the matter sector close with the *real* structure constants
  (`matterGen_lie`), and they commute with the ghosts (`matterGen_comm_ghostCre`,
  `matterGen_comm_ghostAnn`) because they are even.
* **The Standard-Model BRST charge** `smBrstCharge` on the joint matter ⊗ ghost Fock space,
  with **`smBrstCharge_nilpotent`**: `Ω² = 0`, which is what makes the BRST cohomology —
  the physical sector — well defined.

## Honest boundary

The mode set here is finite: one plane-wave matter multiplet and the twelve ghosts, i.e. the
gauge algebra of the collective-coordinate presentation of §D6b-SM.1.  The charge used in
this module is the abstract one, with the constraints `G_a` given as data.  The BRST charge
**as `book.tex` itself defines it** — the density
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc}A_{μb}ψ†_c − (i/2) f_{abc}ψ†_aψ†_bψ_c` with the book's
canonical relations, the Gauss law *derived* from them, and the gauge-fixing fermion
`Ψ = i ψ_a A_{0a}` — is built in `BookProof.ChapterBookBrstYangMills`,
`BookProof.ChapterBookBrstGaugeFixing` and `BookProof.ChapterBookBrstInstances`, the last of
which instantiates it with the Standard-Model structure constants `smStruct f₃`.  The
`su(3)` structure constants enter as a family satisfying antisymmetry and Jacobi (which
`BookProof.ChapterYangMillsSU3` derives for trace-orthonormal generators); the book's
formalism uses no Faddeev–Popov determinant and none is constructed, and no statement about
the *size* of the BRST cohomology is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmBrstGhost

open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

/-! ## 1. The structure constants of `su(3) ⊕ su(2) ⊕ u(1)` -/

/-- The direct sum of two families of structure constants: a bracket never leaves its
summand. -/
def sumStruct {ι κ : Type*} (f1 : ι → ι → ι → ℝ) (f2 : κ → κ → κ → ℝ) :
    (ι ⊕ κ) → (ι ⊕ κ) → (ι ⊕ κ) → ℝ
  | Sum.inl a, Sum.inl b, Sum.inl c => f1 a b c
  | Sum.inr a, Sum.inr b, Sum.inr c => f2 a b c
  | _, _, _ => 0

theorem sumStruct_antisymm {ι κ : Type*} {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ} (h1 : ∀ a b c, f1 a b c = -f1 b a c)
    (h2 : ∀ a b c, f2 a b c = -f2 b a c) (a b c : ι ⊕ κ) :
    sumStruct f1 f2 a b c = -sumStruct f1 f2 b a c := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;>
    simp only [sumStruct, neg_zero] <;> first | rfl | exact h1 a b c | exact h2 a b c

theorem sumStruct_jacobi {ι κ : Type*} [Fintype ι] [Fintype κ] {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ}
    (h1 : ∀ a b c h : ι, ∑ e, (f1 a b e * f1 e c h + f1 b c e * f1 e a h
      + f1 c a e * f1 e b h) = 0)
    (h2 : ∀ a b c h : κ, ∑ e, (f2 a b e * f2 e c h + f2 b c e * f2 e a h
      + f2 c a e * f2 e b h) = 0)
    (a b c h : ι ⊕ κ) :
    ∑ e, (sumStruct f1 f2 a b e * sumStruct f1 f2 e c h
      + sumStruct f1 f2 b c e * sumStruct f1 f2 e a h
      + sumStruct f1 f2 c a e * sumStruct f1 f2 e b h) = 0 := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;> rcases h with h | h <;>
    simp only [Fintype.sum_sum_type, sumStruct, mul_zero, zero_mul, add_zero, zero_add,
      Finset.sum_const_zero] <;>
    first | rfl | exact h1 a b c h | exact h2 a b c h

/-- The Levi-Civita symbol on three indices, as an integer. -/
def epsZ (a b c : Fin 3) : ℤ :=
  if a = b ∨ b = c ∨ a = c then 0
  else if (a, b) = ((0 : Fin 3), (1 : Fin 3)) ∨ (a, b) = ((1 : Fin 3), (2 : Fin 3))
        ∨ (a, b) = ((2 : Fin 3), (0 : Fin 3)) then 1 else -1

/-- **The `su(2)` structure constants** `ε_{jkl}`. -/
def su2Struct (a b c : Fin 3) : ℝ := (epsZ a b c : ℝ)

/-- **The `u(1)` structure constants**: an abelian factor has none. -/
def u1Struct (_ _ _ : Fin 1) : ℝ := 0

theorem epsZ_antisymm : ∀ a b c : Fin 3, epsZ a b c = -epsZ b a c := by decide

theorem epsZ_jacobi : ∀ a b c h : Fin 3,
    ∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h + epsZ c a e * epsZ e b h) = 0 := by
  decide

theorem su2Struct_antisymm (a b c : Fin 3) : su2Struct a b c = -su2Struct b a c := by
  rw [su2Struct, su2Struct, epsZ_antisymm a b c]
  push_cast
  ring

theorem su2Struct_jacobi (a b c h : Fin 3) :
    ∑ e, (su2Struct a b e * su2Struct e c h + su2Struct b c e * su2Struct e a h
      + su2Struct c a e * su2Struct e b h) = 0 := by
  have hz := epsZ_jacobi a b c h
  have : ((∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h
      + epsZ c a e * epsZ e b h) : ℤ) : ℝ) = 0 := by rw [hz]; norm_num
  rw [← this]
  push_cast [su2Struct]
  ring

theorem u1Struct_antisymm (a b c : Fin 1) : u1Struct a b c = -u1Struct b a c := by
  simp [u1Struct]

theorem u1Struct_jacobi (a b c h : Fin 1) :
    ∑ e, (u1Struct a b e * u1Struct e c h + u1Struct b c e * u1Struct e a h
      + u1Struct c a e * u1Struct e b h) = 0 := by
  simp [u1Struct]

/-- The twelve generator labels of the Standard-Model gauge algebra, split into the eight
gluon, three weak and one hypercharge directions. -/
def smIdxEquiv : Fin 12 ≃ (Fin 8 ⊕ (Fin 3 ⊕ Fin 1)) :=
  (finCongr (by norm_num : (12 : ℕ) = 8 + (3 + 1))).trans
    (finSumFinEquiv.symm.trans (Equiv.sumCongr (Equiv.refl (Fin 8)) finSumFinEquiv.symm))

/-- **The structure constants of the Standard-Model gauge algebra** `su(3) ⊕ su(2) ⊕ u(1)`,
given those of `su(3)`. -/
def smStruct (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) (a b c : Fin 12) : ℝ :=
  sumStruct f3 (sumStruct su2Struct u1Struct) (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c)

theorem smStruct_antisymm {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c, f3 a b c = -f3 b a c) (a b c : Fin 12) :
    smStruct f3 a b c = -smStruct f3 b a c := by
  exact sumStruct_antisymm h3
    (sumStruct_antisymm su2Struct_antisymm u1Struct_antisymm) _ _ _

theorem smStruct_jacobi {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) (a b c h : Fin 12) :
    ∑ e, (smStruct f3 a b e * smStruct f3 e c h + smStruct f3 b c e * smStruct f3 e a h
      + smStruct f3 c a e * smStruct f3 e b h) = 0 := by
  have hsum := sumStruct_jacobi (f1 := f3) (f2 := sumStruct su2Struct u1Struct) h3
    (sumStruct_jacobi su2Struct_jacobi u1Struct_jacobi)
    (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c) (smIdxEquiv h)
  rw [← Equiv.sum_comp smIdxEquiv] at hsum
  simpa [smStruct] using hsum

/-! ## 2. The ghost sector inside the CAR algebra -/

variable {m : ℕ}

/-- The mode carrying the `a`-th ghost: the ghosts are the last twelve modes of the
fermionic Fock space, the matter modes being the first `m`. -/
def ghostMode (m : ℕ) (a : Fin 12) : Fin (m + 12) := Fin.natAdd m a

/-- The **ghost creation** operator `c^a`. -/
def ghostCre (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  creat (ghostMode m a)

/-- The **ghost annihilation** (antighost) operator `b_a`. -/
def ghostAnn (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  annih (ghostMode m a)

/-- **The ghosts obey the canonical anticommutation relations.** -/
theorem ghostMode_injective (m : ℕ) : Function.Injective (ghostMode m) := by
  intro a b hab
  have h : m + (a : ℕ) = m + (b : ℕ) := by
    simpa [ghostMode, Fin.ext_iff] using hab
  exact Fin.ext (by omega)

theorem smGhostCAR (m : ℕ) : GhostCAR (ghostCre m) (ghostAnn m) := by
  refine ⟨fun a b => ?_, fun a b => ?_, fun a b => ?_⟩
  · exact car_creat_creat (ghostMode m a) (ghostMode m b)
  · exact car_annih_annih (ghostMode m a) (ghostMode m b)
  · by_cases h : a = b
    · subst h
      rw [if_pos rfl]
      exact car_annih_creat_self (ghostMode m a)
    · rw [if_neg h]
      exact car_annih_creat_of_ne (fun hh => h (ghostMode_injective m hh))

/-- **The ghost-number operator** `Σ_a c^a b_a`. -/
def ghostNumber (m : ℕ) : Module.End ℂ (FermiFock (m + 12)) :=
  ∑ a : Fin 12, ghostCre m a * ghostAnn m a

/-- The mixed canonical anticommutation relation in ring form. -/
theorem annih_mul_creat {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * creat q
      = (if p = q then 1 else 0) - creat q * annih p := by
  by_cases h : p = q
  · subst h
    rw [if_pos rfl]
    exact eq_sub_of_add_eq (car_annih_creat_self p)
  · rw [if_neg h]
    exact eq_sub_of_add_eq (car_annih_creat_of_ne h)

/-- Creation operators anticommute, in ring form. -/
theorem creat_mul_creat {N : ℕ} (p q : Fin N) :
    (creat p : Module.End ℂ (FermiFock N)) * creat q = -(creat q * creat p) :=
  eq_neg_of_add_eq_zero_left (car_creat_creat p q)

/-- Annihilation operators anticommute, in ring form. -/
theorem annih_mul_annih {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * annih q = -(annih q * annih p) :=
  eq_neg_of_add_eq_zero_left (car_annih_annih p q)

/-- The occupation-number operator of a mode on an occupation state. -/
theorem occupation_occ {N : ℕ} (i : Fin N) (S : Finset (Fin N)) :
    creat i (annih i (occ S)) = if i ∈ S then occ S else 0 := by
  ext T
  rw [occupation_apply]
  by_cases h : i ∈ S <;> by_cases hT : T = S <;>
    simp [h, hT, occ, EuclideanSpace.single_apply]

/-- **The ghost number of an occupation state** is the number of occupied ghost modes. -/
theorem ghostNumber_occ (m : ℕ) (S : Finset (Fin (m + 12))) :
    ghostNumber m (occ S)
      = (Finset.univ.filter (fun a : Fin 12 => ghostMode m a ∈ S)).card • occ S := by
  classical
  rw [ghostNumber, LinearMap.sum_apply]
  have hterm : ∀ a : Fin 12, (ghostCre m a * ghostAnn m a) (occ S)
      = if ghostMode m a ∈ S then occ S else 0 := fun a => occupation_occ (ghostMode m a) S
  rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hterm a]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero]

/-- Creation operators square to zero (the Pauli principle). -/
theorem creat_sq {N : ℕ} (i : Fin N) :
    (creat i : Module.End ℂ (FermiFock N)) * creat i = 0 := by
  have h2 : (2 : ℂ) • ((creat i : Module.End ℂ (FermiFock N)) * creat i) = 0 := by
    rw [two_smul]; exact car_creat_creat i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- Annihilation operators square to zero. -/
theorem annih_sq {N : ℕ} (i : Fin N) :
    (annih i : Module.End ℂ (FermiFock N)) * annih i = 0 := by
  have h2 : (2 : ℂ) • ((annih i : Module.End ℂ (FermiFock N)) * annih i) = 0 := by
    rw [two_smul]; exact car_annih_annih i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- A ghost creation operator raises the ghost number by one. -/
theorem ghostNumber_comm_ghostCre (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostCre m a - ghostCre m a * ghostNumber m = ghostCre m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * (1 - ghostCre m a * ghostAnn m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by rw [hAC]
      _ = ghostCre m a := by
            have hsq : (ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a = 0 := by
              rw [ghostCre]; exact creat_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (1 - ghostCre m a * ghostAnn m a)
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a
                = ghostCre m a - (ghostCre m a * ghostCre m a) * ghostAnn m a
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
              _ = ghostCre m a := by rw [hsq]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostAnn m b) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg hne, zero_sub]
    have hCC : (ghostCre m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostCre m b) := by
      rw [ghostCre, ghostCre, creat_mul_creat]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = ghostCre m b * -(ghostCre m a * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hAC]
      _ = -((ghostCre m b * ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = -((-(ghostCre m a * ghostCre m b) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hCC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha

/-- A ghost annihilation operator lowers the ghost number by one. -/
theorem ghostNumber_comm_ghostAnn (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostAnn m a - ghostAnn m a * ghostNumber m = -ghostAnn m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
          - ghostAnn m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
              * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - (1 - ghostCre m a * ghostAnn m a) * ghostAnn m a := by rw [hAC]
      _ = -ghostAnn m a := by
            have hsqA : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a = 0 := by
              rw [ghostAnn]; exact annih_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (ghostAnn m a * ghostAnn m a)
                  - (1 - ghostCre m a * ghostAnn m a) * ghostAnn m a
                = ghostCre m a * (ghostAnn m a * ghostAnn m a) - ghostAnn m a
                  + ghostCre m a * (ghostAnn m a * ghostAnn m a) := by noncomm_ring
              _ = -ghostAnn m a := by rw [hsqA]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m b
        = -(ghostCre m b * ghostAnn m a) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg (fun hh => hne hh.symm), zero_sub]
    have hAA : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
        = -(ghostAnn m a * ghostAnn m b) := by
      rw [ghostAnn, ghostAnn, annih_mul_annih]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
          - ghostAnn m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m b)
              * ghostAnn m b := by noncomm_ring
      _ = ghostCre m b * -((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - (-(ghostCre m b * ghostAnn m a) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b := by rw [hAA, hAC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha

/-- **The cubic ghost part of the Standard-Model BRST charge.** -/
def smGhostCharge (m : ℕ) (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    Module.End ℂ (FermiFock (m + 12)) :=
  Q (smStruct f3) (ghostCre m) (ghostAnn m)

/-- **The cubic ghost charge of the Standard Model is nilpotent.** -/
theorem smGhostCharge_nilpotent (m : ℕ) {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3anti : ∀ a b c, f3 a b c = -f3 b a c)
    (h3jac : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) :
    smGhostCharge m f3 * smGhostCharge m f3 = 0 :=
  brst_charge_nilpotent (smStruct f3) (ghostCre m) (ghostAnn m) (smGhostCAR m)
    (smStruct_antisymm h3anti) (smStruct_jacobi h3jac)

/-! ## 3. The full BRST charge, in the abstract -/

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}

/-- Rotating the innermost index of a threefold sum to the front. -/
theorem sum_rotate3 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := by
  calc ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, F a d g :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := Finset.sum_comm

/-- Rotating the innermost index of a fourfold sum to the front. -/
theorem sum_rotate4 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := by
  calc ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, ∑ h : Fin n, F a d g h :=
        Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun g _ => Finset.sum_comm
    _ = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := Finset.sum_comm

/-- **The BRST charge** `Ω = Σ_a c^a G_a − ½ f_{abc} c^a c^b b_c` of a family of first-class
constraints `G_a`. -/
def brstCharge (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R) (G : Fin n → R) : R :=
  (∑ a, χ a * G a) - (1 / 2 : ℝ) • Q f χ β

/-- **Nilpotency of the full BRST charge.**  If the ghosts obey the CAR, the constraints
commute with the ghosts and close with real structure constants that are antisymmetric and
satisfy the Jacobi identity, then `Ω² = 0` — the fact that makes the BRST cohomology, hence
the physical (gauge-invariant) sector, well defined. -/
theorem brstCharge_nilpotent (f : Fin n → Fin n → Fin n → ℝ) (χ β G : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hGχ : ∀ a b, G a * χ b = χ b * G a) (hGβ : ∀ a b, G a * β b = β b * G a)
    (hclose : ∀ a b, G a * G b - G b * G a = ∑ c, f a b c • G c)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    brstCharge f χ β G * brstCharge f χ β G = 0 := by
  classical
  -- the two halves of the charge
  set X : R := ∑ a, χ a * G a with hXdef
  -- moving a ghost creation operator through a cubic ghost monomial
  have hmove : ∀ a d g h : Fin n,
      χ a * (χ d * χ g * β h) + (χ d * χ g * β h) * χ a
        = (if h = a then (1 : R) else 0) * (χ d * χ g) := by
    intro a d g h
    have hb : β h * χ a = (if h = a then (1 : R) else 0) - χ a * β h :=
      eq_sub_of_add_eq (hCAR.betachi h a)
    have hda : χ d * χ a = -(χ a * χ d) := eq_neg_of_add_eq_zero_left (hCAR.chichi d a)
    have hga : χ g * χ a = -(χ a * χ g) := eq_neg_of_add_eq_zero_left (hCAR.chichi g a)
    have h3 : χ d * χ g * χ a = χ a * (χ d * χ g) := by
      calc χ d * χ g * χ a = χ d * (χ g * χ a) := by noncomm_ring
        _ = χ d * -(χ a * χ g) := by rw [hga]
        _ = -((χ d * χ a) * χ g) := by noncomm_ring
        _ = -((-(χ a * χ d)) * χ g) := by rw [hda]
        _ = χ a * (χ d * χ g) := by noncomm_ring
    have key : (χ d * χ g * β h) * χ a
        = (if h = a then (1 : R) else 0) * (χ d * χ g) - χ a * (χ d * χ g * β h) := by
      have h1 : (χ d * χ g * β h) * χ a = χ d * χ g * (β h * χ a) := by noncomm_ring
      rw [h1, hb]
      have h2 : χ d * χ g * ((if h = a then (1 : R) else 0) - χ a * β h)
          = (if h = a then (1 : R) else 0) * (χ d * χ g) - (χ d * χ g * χ a) * β h := by
        by_cases hh : h = a
        · simp only [hh, if_pos]; noncomm_ring
        · simp only [if_neg hh]; noncomm_ring
      rw [h2, h3]
      noncomm_ring
    rw [key]
    abel
  -- the square of the linear part
  have hXXexp : X * X = ∑ a, ∑ b, (χ a * χ b) * (G a * G b) := by
    rw [hXdef, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [show (χ a * G a) * (χ b * G b) = χ a * (G a * χ b) * G b by noncomm_ring, hGχ a b]
    noncomm_ring
  have hswap : (∑ a, ∑ b, (χ a * χ b) * (G b * G a))
      = -∑ a, ∑ b, (χ a * χ b) * (G a * G b) := by
    rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [show χ b * χ a = -(χ a * χ b) from eq_neg_of_add_eq_zero_left (hCAR.chichi b a)]
    noncomm_ring
  have hXX2 : (2 : ℝ) • (X * X) = ∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * G c) := by
    rw [two_smul, hXXexp]
    nth_rewrite 2 [show (∑ a, ∑ b, (χ a * χ b) * (G a * G b))
        = -∑ a, ∑ b, (χ a * χ b) * (G b * G a) from by rw [hswap, neg_neg]]
    rw [← sub_eq_add_neg, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← mul_sub, hclose a b, Finset.mul_sum]
    exact Finset.sum_congr rfl fun c _ => by rw [mul_smul_comm]
  -- the cross term
  have hXQ : X * Q f χ β + Q f χ β * X = ∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * G c) := by
    have hX1 : X * Q f χ β
        = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((χ a * G a) * (χ d * χ g * β h)) := by
      rw [hXdef, Q, Finset.sum_mul]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun h _ => by rw [mul_smul_comm]
    have hQ1 : Q f χ β * X
        = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((χ d * χ g * β h) * (χ a * G a)) := by
      rw [← sum_rotate4 (fun a d g h => f d g h • ((χ d * χ g * β h) * (χ a * G a)))]
      rw [hXdef, Q, Finset.sum_mul]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun h _ => ?_
      rw [smul_mul_assoc, Finset.mul_sum, Finset.smul_sum]
    rw [hX1, hQ1, ← Finset.sum_add_distrib]
    have hcollapse : ∀ a : Fin n,
        ((∑ d, ∑ g, ∑ h, f d g h • ((χ a * G a) * (χ d * χ g * β h)))
          + ∑ d, ∑ g, ∑ h, f d g h • ((χ d * χ g * β h) * (χ a * G a)))
        = ∑ d, ∑ g, f d g a • (χ d * χ g * G a) := by
      intro a
      simp only [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun d _ => ?_
      refine Finset.sum_congr rfl fun g _ => ?_
      have hterm : ∀ h : Fin n,
          f d g h • ((χ a * G a) * (χ d * χ g * β h))
            + f d g h • ((χ d * χ g * β h) * (χ a * G a))
          = f d g h • ((if h = a then (1 : R) else 0) * (χ d * χ g * G a)) := by
        intro h
        rw [← smul_add]
        congr 1
        have hc1 : (χ a * G a) * (χ d * χ g * β h) = (χ a * (χ d * χ g * β h)) * G a := by
          have hg1 : G a * (χ d * χ g * β h) = (χ d * χ g * β h) * G a := by
            rw [show G a * (χ d * χ g * β h) = ((G a * χ d) * χ g) * β h by noncomm_ring,
              hGχ a d,
              show ((χ d * G a) * χ g) * β h = (χ d * (G a * χ g)) * β h by noncomm_ring,
              hGχ a g,
              show (χ d * (χ g * G a)) * β h = (χ d * χ g) * (G a * β h) by noncomm_ring,
              hGβ a h]
            noncomm_ring
          calc (χ a * G a) * (χ d * χ g * β h)
              = χ a * (G a * (χ d * χ g * β h)) := by noncomm_ring
            _ = χ a * ((χ d * χ g * β h) * G a) := by rw [hg1]
            _ = (χ a * (χ d * χ g * β h)) * G a := by noncomm_ring
        have hc2 : (χ d * χ g * β h) * (χ a * G a)
            = ((χ d * χ g * β h) * χ a) * G a := by noncomm_ring
        rw [hc1, hc2, ← add_mul, hmove a d g h]
        noncomm_ring
      rw [Finset.sum_congr rfl fun h (_ : h ∈ Finset.univ) => hterm h]
      rw [Finset.sum_eq_single a]
      · rw [if_pos rfl, one_mul]
      · intro h _ hh
        rw [if_neg hh, zero_mul, smul_zero]
      · intro ha
        exact absurd (Finset.mem_univ a) ha
    rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hcollapse a]
    rw [← sum_rotate3 (fun a d g => f d g a • (χ d * χ g * G a))]
  -- nilpotency of the cubic ghost term
  have hQnil : Q f χ β * Q f χ β = 0 := brst_charge_nilpotent f χ β hCAR hf12 hjac
  -- assemble
  have h2 : (2 : ℝ) • (brstCharge f χ β G * brstCharge f χ β G) = 0 := by
    have hexp : brstCharge f χ β G * brstCharge f χ β G
        = X * X - (1 / 2 : ℝ) • (X * Q f χ β + Q f χ β * X)
          + (1 / 2 : ℝ) • ((1 / 2 : ℝ) • (Q f χ β * Q f χ β)) := by
      rw [brstCharge, ← hXdef]
      simp only [sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm, smul_add, smul_sub]
      abel
    have htwo : ((2 : ℝ) * (1 / 2 : ℝ)) = 1 := by norm_num
    rw [hexp, hQnil, smul_zero, smul_zero, add_zero, smul_sub, smul_smul, htwo, one_smul,
      hXX2, hXQ, sub_self]
  have hne : (2 : ℝ) ≠ 0 := two_ne_zero
  rcases smul_eq_zero.mp h2 with h | h
  · exact absurd h hne
  · exact h

/-! ## 4. The Gauss-law constraints: second quantization as a Lie homomorphism -/

variable {N : ℕ}

/-- The commutator of two occupation bilinears, from the canonical anticommutation
relations. -/
theorem creat_annih_commutator (i j k l : Fin N) :
    (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        - (creat k * annih l) * (creat i * annih j)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by
  have e1 : (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - creat i * creat k * (annih j * annih l) := by
    have h0 : (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * creat k) * annih l := by
      noncomm_ring
    rw [h0, annih_mul_creat j k]
    by_cases h : j = k
    · rw [if_pos h, if_pos h]; noncomm_ring
    · rw [if_neg h, if_neg h]; noncomm_ring
  have e2 : (creat k * annih l : Module.End ℂ (FermiFock N)) * (creat i * annih j)
      = (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
        - creat k * creat i * (annih l * annih j) := by
    have h0 : (creat k * annih l : Module.End ℂ (FermiFock N)) * (creat i * annih j)
        = creat k * ((annih l : Module.End ℂ (FermiFock N)) * creat i) * annih j := by
      noncomm_ring
    rw [h0, annih_mul_creat l i]
    by_cases h : l = i
    · rw [if_pos h, if_pos h]; noncomm_ring
    · rw [if_neg h, if_neg h]; noncomm_ring
  have e3 : (creat k * creat i : Module.End ℂ (FermiFock N)) * (annih l * annih j)
      = creat i * creat k * (annih j * annih l) := by
    rw [creat_mul_creat k i, annih_mul_annih l j]
    noncomm_ring
  rw [e1, e2, e3]
  abel

/-- The second quantization written with the ring multiplication of `Module.End`. -/
theorem fermiBilin_eq4 (M : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N))
      = ∑ i : Fin N, ∑ j : Fin N, M i j • (creat i * annih j) := rfl

theorem fermiBilin_sub (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (M - P) : Module.End ℂ (FermiFock N)) = fermiBilin M - fermiBilin P := by
  rw [fermiBilin_eq4, fermiBilin_eq4, fermiBilin_eq4, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [Matrix.sub_apply, sub_smul]

theorem fermiBilin_mul4 (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N)) * fermiBilin P
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (M i j * P k l) • ((creat i * annih j) * (creat k * annih l)) := by
  rw [fermiBilin_eq4, fermiBilin_eq4, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [smul_mul_assoc, mul_smul_comm, smul_smul]

/-- Swapping the two index pairs of a fourfold sum. -/
theorem sum4_swap (F : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N)) :
    ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
  calc ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ q : Fin N × Fin N, ∑ p : Fin N × Fin N, F p.1 p.2 q.1 q.2 := by
        simp [Fintype.sum_prod_type]
    _ = ∑ p : Fin N × Fin N, ∑ q : Fin N × Fin N, F p.1 p.2 q.1 q.2 := Finset.sum_comm
    _ = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
        simp [Fintype.sum_prod_type]

/-- The first delta contraction of the commutator sum. -/
theorem sum_delta_left (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (M * P) := by
  have step1 : ∀ i j : Fin N,
      (∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0))
        = ∑ l : Fin N, (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
    intro i j
    rw [Finset.sum_eq_single j]
    · exact Finset.sum_congr rfl fun l _ => by rw [if_pos rfl]
    · intro k _ hk
      exact Finset.sum_eq_zero fun l _ => by rw [if_neg (Ne.symm hk), smul_zero]
    · intro hj
      exact absurd (Finset.mem_univ j) hj
  calc ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ l : Fin N,
          (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => step1 i j
    _ = ∑ i : Fin N, ∑ l : Fin N, ∑ j : Fin N,
          (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ i : Fin N, ∑ l : Fin N,
          ((M * P) i l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
    _ = fermiBilin (M * P) := (fermiBilin_eq4 (M * P)).symm

/-- The second delta contraction of the commutator sum. -/
theorem sum_delta_right (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (P * M) := by
  have step1 : ∀ i j k : Fin N,
      (∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0))
        = (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
    intro i j k
    rw [Finset.sum_eq_single i]
    · rw [if_pos rfl]
    · intro l _ hl
      rw [if_neg hl, smul_zero]
    · intro hi
      exact absurd (Finset.mem_univ i) hi
  calc ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
          Finset.sum_congr rfl fun k _ => step1 i j k
    _ = ∑ i : Fin N, ∑ k : Fin N, ∑ j : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k : Fin N, ∑ i : Fin N, ∑ j : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := Finset.sum_comm
    _ = ∑ k : Fin N, ∑ j : Fin N, ∑ i : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k : Fin N, ∑ j : Fin N,
          ((P * M) k j) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
        congr 1
        exact Finset.sum_congr rfl fun i _ => by ring
    _ = fermiBilin (P * M) := (fermiBilin_eq4 (P * M)).symm

/-- **Second quantization is a Lie-algebra homomorphism**: `[dΓ(A), dΓ(B)] = dΓ([A,B])`. -/
theorem fermiBilin_lie (A B : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * fermiBilin B
        - fermiBilin B * fermiBilin A
      = fermiBilin (A * B - B * A) := by
  have h2 : (fermiBilin B : Module.End ℂ (FermiFock N)) * fermiBilin A
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (A i j * B k l) • ((creat k * annih l) * (creat i * annih j)) := by
    rw [fermiBilin_mul4 B A,
      ← sum4_swap (fun i j k l =>
        (A i j * B k l) • ((creat k * annih l : Module.End ℂ (FermiFock N))
          * (creat i * annih j)))]
    exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [mul_comm]
  rw [fermiBilin_mul4 A B, h2]
  have hcomb : ∀ X Y : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N),
      (∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, X i j k l)
        - (∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, Y i j k l)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, (X i j k l - Y i j k l) := by
    intro X Y
    simp only [← Finset.sum_sub_distrib]
  rw [hcomb]
  have hterm : ∀ i j k l : Fin N,
      ((A i j * B k l) • ((creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l))
        - (A i j * B k l) • ((creat k * annih l : Module.End ℂ (FermiFock N))
            * (creat i * annih j)))
      = (A i j * B k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (A i j * B k l)
            • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by
    intro i j k l
    rw [← smul_sub, ← smul_sub, creat_annih_commutator i j k l]
  rw [Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => Finset.sum_congr rfl
    fun j (_ : j ∈ Finset.univ) => Finset.sum_congr rfl fun k (_ : k ∈ Finset.univ) =>
      Finset.sum_congr rfl fun l (_ : l ∈ Finset.univ) => hterm i j k l]
  rw [← hcomb, sum_delta_left A B, sum_delta_right A B, ← fermiBilin_sub]

/-- A second-quantized operator whose `k`-th column vanishes commutes with the creation
operator of the mode `k`: bilinears are even. -/
theorem fermiBilin_comm_creat {A : Matrix (Fin N) (Fin N) ℂ} {k : Fin N}
    (hcol : ∀ i, A i k = 0) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * creat k
      = creat k * fermiBilin A := by
  rw [fermiBilin_eq4, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases h : j = k
  · subst h
    rw [hcol i, zero_smul, zero_mul, mul_zero]
  · rw [smul_mul_assoc, mul_smul_comm]
    congr 1
    have h1 : (annih j : Module.End ℂ (FermiFock N)) * creat k = -(creat k * annih j) := by
      rw [annih_mul_creat j k, if_neg h, zero_sub]
    calc (creat i * annih j : Module.End ℂ (FermiFock N)) * creat k
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * creat k) := by noncomm_ring
      _ = creat i * -(creat k * annih j) := by rw [h1]
      _ = -((creat i : Module.End ℂ (FermiFock N)) * creat k) * annih j := by noncomm_ring
      _ = -(-((creat k : Module.End ℂ (FermiFock N)) * creat i)) * annih j := by
            rw [creat_mul_creat i k]
      _ = creat k * (creat i * annih j) := by noncomm_ring

/-- A second-quantized operator whose `k`-th row vanishes commutes with the annihilation
operator of the mode `k`. -/
theorem fermiBilin_comm_annih {A : Matrix (Fin N) (Fin N) ℂ} {k : Fin N}
    (hrow : ∀ j, A k j = 0) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * annih k
      = annih k * fermiBilin A := by
  rw [fermiBilin_eq4, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases h : i = k
  · subst h
    rw [hrow j, zero_smul, zero_mul, mul_zero]
  · rw [smul_mul_assoc, mul_smul_comm]
    congr 1
    have h1 : (annih k : Module.End ℂ (FermiFock N)) * creat i = -(creat i * annih k) := by
      rw [annih_mul_creat k i, if_neg (fun hh => h hh.symm), zero_sub]
    calc (creat i * annih j : Module.End ℂ (FermiFock N)) * annih k
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * annih k) := by noncomm_ring
      _ = creat i * -((annih k : Module.End ℂ (FermiFock N)) * annih j) := by
            rw [annih_mul_annih j k]
      _ = -((creat i : Module.End ℂ (FermiFock N)) * annih k) * annih j := by noncomm_ring
      _ = ((annih k : Module.End ℂ (FermiFock N)) * creat i) * annih j := by rw [← h1]
      _ = annih k * (creat i * annih j) := by noncomm_ring





/-- Second quantization commutes with finite sums of one-particle matrices. -/
theorem fermiBilin_sum {ι : Type*} (s : Finset ι) (M : ι → Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (∑ t ∈ s, M t) : Module.End ℂ (FermiFock N))
      = ∑ t ∈ s, fermiBilin (M t) := by
  classical
  induction s using Finset.induction with
  | empty =>
      rw [Finset.sum_empty, Finset.sum_empty, fermiBilin_eq4]
      refine Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => ?_
      simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, ← ih]
      exact fermiBilin_add' (M a) (∑ t ∈ s, M t)

/-! ## 5. The Standard-Model BRST charge -/

/-- The matter block of a one-particle operator, embedded in the joint matter ⊗ ghost mode
set: the operator acts on the first `m` modes and annihilates the ghosts. -/
def embedMatter (m : ℕ) (M : Matrix (Fin m) (Fin m) ℂ) :
    Matrix (Fin (m + 12)) (Fin (m + 12)) ℂ :=
  Matrix.reindex finSumFinEquiv finSumFinEquiv (Matrix.fromBlocks M 0 0 0)

/-- **The Gauss-law generator** of the `a`-th gauge direction: the second quantization
`−i dΓ(T_a)` of the one-particle generator on the matter modes. -/
def matterGen (m : ℕ) (T : Fin 12 → Matrix (Fin m) (Fin m) ℂ) (a : Fin 12) :
    Module.End ℂ (FermiFock (m + 12)) :=
  (-Complex.I) • fermiBilin (embedMatter m (T a))













t antisymmetry and the Jacobi identity are inherited;
  `su2Struct` is the concrete `su(2)` Levi-Civita family (antisymmetry and Jacobi by finite
  check), `u1Struct` the abelian one, and `smStruct f₃` assembles them with an `su(3)`
  family `f₃` into the twelve-generator family, with **`smStruct_antisymm`** and
  **`smStruct_jacobi`**: the Standard-Model gauge algebra has totally antisymmetric
  structure constants obeying Jacobi, which is exactly what BRST needs.
* **The ghost sector on the CAR algebra.**  The ghosts are the last twelve modes of the
  fermionic Fock space of `BookProof.ChapterSmCarAlgebra`; `smGhostCAR` is their canonical
  anticommutation relations, `ghostNumber` the ghost-number operator with
  `ghostNumber_occ` (its spectrum is the ghost occupation number) and the commutators
  `ghostNumber_comm_ghostCre`, `ghostNumber_comm_ghostAnn`.
* **The cubic ghost charge is nilpotent** — `smGhostCharge_nilpotent`, through the project's
  `BookProof.BRSTNilpotent.brst_charge_nilpotent` with the Standard-Model structure
  constants.
* **The full BRST charge is nilpotent** — `brstCharge_nilpotent`, an algebraic theorem in
  any ring carrying ghosts with the CAR and constraint operators `G_a` that commute with
  the ghosts and close with the structure constants: `Ω² = 0`.
* **Second quantization is a Lie-algebra homomorphism** — `fermiBilin_lie`,
  `creat_annih_commutator`: `[dΓ(A), dΓ(B)] = dΓ([A,B])`, so the Gauss-law generators
  `G_a = −i dΓ(T_a)` of the matter sector close with the *real* structure constants
  (`matterGen_lie`), and they commute with the ghosts (`matterGen_comm_ghostCre`,
  `matterGen_comm_ghostAnn`) because they are even.
* **The Standard-Model BRST charge** `smBrstCharge` on the joint matter ⊗ ghost Fock space,
  with **`smBrstCharge_nilpotent`**: `Ω² = 0`, which is what makes the BRST cohomology —
  the physical sector — well defined.

## Honest boundary

The mode set here is finite: one plane-wave matter multiplet and the twelve ghosts, i.e. the
gauge algebra of the collective-coordinate presentation of §D6b-SM.1.  The charge used in
this module is the abstract one, with the constraints `G_a` given as data.  The BRST charge
**as `book.tex` itself defines it** — the density
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc}A_{μb}ψ†_c − (i/2) f_{abc}ψ†_aψ†_bψ_c` with the book's
canonical relations, the Gauss law *derived* from them, and the gauge-fixing fermion
`Ψ = i ψ_a A_{0a}` — is built in `BookProof.ChapterBookBrstYangMills`,
`BookProof.ChapterBookBrstGaugeFixing` and `BookProof.ChapterBookBrstInstances`, the last of
which instantiates it with the Standard-Model structure constants `smStruct f₃`.  The
`su(3)` structure constants enter as a family satisfying antisymmetry and Jacobi (which
`BookProof.ChapterYangMillsSU3` derives for trace-orthonormal generators); the book's
formalism uses no Faddeev–Popov determinant and none is constructed, and no statement about
the *size* of the BRST cohomology is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmBrstGhost

open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

/-! ## 1. The structure constants of `su(3) ⊕ su(2) ⊕ u(1)` -/

/-- The direct sum of two families of structure constants: a bracket never leaves its
summand. -/
def sumStruct {ι κ : Type*} (f1 : ι → ι → ι → ℝ) (f2 : κ → κ → κ → ℝ) :
    (ι ⊕ κ) → (ι ⊕ κ) → (ι ⊕ κ) → ℝ
  | Sum.inl a, Sum.inl b, Sum.inl c => f1 a b c
  | Sum.inr a, Sum.inr b, Sum.inr c => f2 a b c
  | _, _, _ => 0

theorem sumStruct_antisymm {ι κ : Type*} {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ} (h1 : ∀ a b c, f1 a b c = -f1 b a c)
    (h2 : ∀ a b c, f2 a b c = -f2 b a c) (a b c : ι ⊕ κ) :
    sumStruct f1 f2 a b c = -sumStruct f1 f2 b a c := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;>
    simp only [sumStruct, neg_zero] <;> first | rfl | exact h1 a b c | exact h2 a b c

theorem sumStruct_jacobi {ι κ : Type*} [Fintype ι] [Fintype κ] {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ}
    (h1 : ∀ a b c h : ι, ∑ e, (f1 a b e * f1 e c h + f1 b c e * f1 e a h
      + f1 c a e * f1 e b h) = 0)
    (h2 : ∀ a b c h : κ, ∑ e, (f2 a b e * f2 e c h + f2 b c e * f2 e a h
      + f2 c a e * f2 e b h) = 0)
    (a b c h : ι ⊕ κ) :
    ∑ e, (sumStruct f1 f2 a b e * sumStruct f1 f2 e c h
      + sumStruct f1 f2 b c e * sumStruct f1 f2 e a h
      + sumStruct f1 f2 c a e * sumStruct f1 f2 e b h) = 0 := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;> rcases h with h | h <;>
    simp only [Fintype.sum_sum_type, sumStruct, mul_zero, zero_mul, add_zero, zero_add,
      Finset.sum_const_zero] <;>
    first | rfl | exact h1 a b c h | exact h2 a b c h

/-- The Levi-Civita symbol on three indices, as an integer. -/
def epsZ (a b c : Fin 3) : ℤ :=
  if a = b ∨ b = c ∨ a = c then 0
  else if (a, b) = ((0 : Fin 3), (1 : Fin 3)) ∨ (a, b) = ((1 : Fin 3), (2 : Fin 3))
        ∨ (a, b) = ((2 : Fin 3), (0 : Fin 3)) then 1 else -1

/-- **The `su(2)` structure constants** `ε_{jkl}`. -/
def su2Struct (a b c : Fin 3) : ℝ := (epsZ a b c : ℝ)

/-- **The `u(1)` structure constants**: an abelian factor has none. -/
def u1Struct (_ _ _ : Fin 1) : ℝ := 0

theorem epsZ_antisymm : ∀ a b c : Fin 3, epsZ a b c = -epsZ b a c := by decide

theorem epsZ_jacobi : ∀ a b c h : Fin 3,
    ∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h + epsZ c a e * epsZ e b h) = 0 := by
  decide

theorem su2Struct_antisymm (a b c : Fin 3) : su2Struct a b c = -su2Struct b a c := by
  rw [su2Struct, su2Struct, epsZ_antisymm a b c]
  push_cast
  ring

theorem su2Struct_jacobi (a b c h : Fin 3) :
    ∑ e, (su2Struct a b e * su2Struct e c h + su2Struct b c e * su2Struct e a h
      + su2Struct c a e * su2Struct e b h) = 0 := by
  have hz := epsZ_jacobi a b c h
  have : ((∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h
      + epsZ c a e * epsZ e b h) : ℤ) : ℝ) = 0 := by rw [hz]; norm_num
  rw [← this]
  push_cast [su2Struct]
  ring

theorem u1Struct_antisymm (a b c : Fin 1) : u1Struct a b c = -u1Struct b a c := by
  simp [u1Struct]

theorem u1Struct_jacobi (a b c h : Fin 1) :
    ∑ e, (u1Struct a b e * u1Struct e c h + u1Struct b c e * u1Struct e a h
      + u1Struct c a e * u1Struct e b h) = 0 := by
  simp [u1Struct]

/-- The twelve generator labels of the Standard-Model gauge algebra, split into the eight
gluon, three weak and one hypercharge directions. -/
def smIdxEquiv : Fin 12 ≃ (Fin 8 ⊕ (Fin 3 ⊕ Fin 1)) :=
  (finCongr (by norm_num : (12 : ℕ) = 8 + (3 + 1))).trans
    (finSumFinEquiv.symm.trans (Equiv.sumCongr (Equiv.refl (Fin 8)) finSumFinEquiv.symm))

/-- **The structure constants of the Standard-Model gauge algebra** `su(3) ⊕ su(2) ⊕ u(1)`,
given those of `su(3)`. -/
def smStruct (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) (a b c : Fin 12) : ℝ :=
  sumStruct f3 (sumStruct su2Struct u1Struct) (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c)

theorem smStruct_antisymm {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c, f3 a b c = -f3 b a c) (a b c : Fin 12) :
    smStruct f3 a b c = -smStruct f3 b a c := by
  exact sumStruct_antisymm h3
    (sumStruct_antisymm su2Struct_antisymm u1Struct_antisymm) _ _ _

theorem smStruct_jacobi {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) (a b c h : Fin 12) :
    ∑ e, (smStruct f3 a b e * smStruct f3 e c h + smStruct f3 b c e * smStruct f3 e a h
      + smStruct f3 c a e * smStruct f3 e b h) = 0 := by
  have hsum := sumStruct_jacobi (f1 := f3) (f2 := sumStruct su2Struct u1Struct) h3
    (sumStruct_jacobi su2Struct_jacobi u1Struct_jacobi)
    (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c) (smIdxEquiv h)
  rw [← Equiv.sum_comp smIdxEquiv] at hsum
  simpa [smStruct] using hsum

/-! ## 2. The ghost sector inside the CAR algebra -/

variable {m : ℕ}

/-- The mode carrying the `a`-th ghost: the ghosts are the last twelve modes of the
fermionic Fock space, the matter modes being the first `m`. -/
def ghostMode (m : ℕ) (a : Fin 12) : Fin (m + 12) := Fin.natAdd m a

/-- The **ghost creation** operator `c^a`. -/
def ghostCre (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  creat (ghostMode m a)

/-- The **ghost annihilation** (antighost) operator `b_a`. -/
def ghostAnn (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  annih (ghostMode m a)

/-- **The ghosts obey the canonical anticommutation relations.** -/
theorem ghostMode_injective (m : ℕ) : Function.Injective (ghostMode m) := by
  intro a b hab
  have h : m + (a : ℕ) = m + (b : ℕ) := by
    simpa [ghostMode, Fin.ext_iff] using hab
  exact Fin.ext (by omega)

theorem smGhostCAR (m : ℕ) : GhostCAR (ghostCre m) (ghostAnn m) := by
  refine ⟨fun a b => ?_, fun a b => ?_, fun a b => ?_⟩
  · exact car_creat_creat (ghostMode m a) (ghostMode m b)
  · exact car_annih_annih (ghostMode m a) (ghostMode m b)
  · by_cases h : a = b
    · subst h
      rw [if_pos rfl]
      exact car_annih_creat_self (ghostMode m a)
    · rw [if_neg h]
      exact car_annih_creat_of_ne (fun hh => h (ghostMode_injective m hh))

/-- **The ghost-number operator** `Σ_a c^a b_a`. -/
def ghostNumber (m : ℕ) : Module.End ℂ (FermiFock (m + 12)) :=
  ∑ a : Fin 12, ghostCre m a * ghostAnn m a

/-- The mixed canonical anticommutation relation in ring form. -/
theorem annih_mul_creat {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * creat q
      = (if p = q then 1 else 0) - creat q * annih p := by
  by_cases h : p = q
  · subst h
    rw [if_pos rfl]
    exact eq_sub_of_add_eq (car_annih_creat_self p)
  · rw [if_neg h]
    exact eq_sub_of_add_eq (car_annih_creat_of_ne h)

/-- Creation operators anticommute, in ring form. -/
theorem creat_mul_creat {N : ℕ} (p q : Fin N) :
    (creat p : Module.End ℂ (FermiFock N)) * creat q = -(creat q * creat p) :=
  eq_neg_of_add_eq_zero_left (car_creat_creat p q)

/-- Annihilation operators anticommute, in ring form. -/
theorem annih_mul_annih {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * annih q = -(annih q * annih p) :=
  eq_neg_of_add_eq_zero_left (car_annih_annih p q)

/-- The occupation-number operator of a mode on an occupation state. -/
theorem occupation_occ {N : ℕ} (i : Fin N) (S : Finset (Fin N)) :
    creat i (annih i (occ S)) = if i ∈ S then occ S else 0 := by
  ext T
  rw [occupation_apply]
  by_cases h : i ∈ S <;> by_cases hT : T = S <;>
    simp [h, hT, occ, EuclideanSpace.single_apply]

/-- **The ghost number of an occupation state** is the number of occupied ghost modes. -/
theorem ghostNumber_occ (m : ℕ) (S : Finset (Fin (m + 12))) :
    ghostNumber m (occ S)
      = (Finset.univ.filter (fun a : Fin 12 => ghostMode m a ∈ S)).card • occ S := by
  classical
  rw [ghostNumber, LinearMap.sum_apply]
  have hterm : ∀ a : Fin 12, (ghostCre m a * ghostAnn m a) (occ S)
      = if ghostMode m a ∈ S then occ S else 0 := fun a => occupation_occ (ghostMode m a) S
  rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hterm a]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero]

/-- Creation operators square to zero (the Pauli principle). -/
theorem creat_sq {N : ℕ} (i : Fin N) :
    (creat i : Module.End ℂ (FermiFock N)) * creat i = 0 := by
  have h2 : (2 : ℂ) • ((creat i : Module.End ℂ (FermiFock N)) * creat i) = 0 := by
    rw [two_smul]; exact car_creat_creat i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- Annihilation operators square to zero. -/
theorem annih_sq {N : ℕ} (i : Fin N) :
    (annih i : Module.End ℂ (FermiFock N)) * annih i = 0 := by
  have h2 : (2 : ℂ) • ((annih i : Module.End ℂ (FermiFock N)) * annih i) = 0 := by
    rw [two_smul]; exact car_annih_annih i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- A ghost creation operator raises the ghost number by one. -/
theorem ghostNumber_comm_ghostCre (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostCre m a - ghostCre m a * ghostNumber m = ghostCre m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * (1 - ghostCre m a * ghostAnn m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by rw [hAC]
      _ = ghostCre m a := by
            have hsq : (ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a = 0 := by
              rw [ghostCre]; exact creat_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (1 - ghostCre m a * ghostAnn m a)
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a
                = ghostCre m a - (ghostCre m a * ghostCre m a) * ghostAnn m a
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
              _ = ghostCre m a := by rw [hsq]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostAnn m b) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg hne, zero_sub]
    have hCC : (ghostCre m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostCre m b) := by
      rw [ghostCre, ghostCre, creat_mul_creat]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = ghostCre m b * -(ghostCre m a * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hAC]
      _ = -((ghostCre m b * ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = -((-(ghostCre m a * ghostCre m b) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hCC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha

/-- A ghost annihilation operator lowers the ghost number by one. -/
theorem ghostNumber_comm_ghostAnn (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostAnn m a - ghostAnn m a * ghostNumber m = -ghostAnn m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
          - ghostAnn m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
              * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - (1 - ghostCre m a * ghostAnn m a) * ghostAnn m a := by rw [hAC]
      _ = -ghostAnn m a := by
            have hsqA : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a = 0 := by
              rw [ghostAnn]; exact annih_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (ghostAnn m a * ghostAnn m a)
                  - (1 - ghostCre m a * ghostAnn m a) * ghostAnn m a
                = ghostCre m a * (ghostAnn m a * ghostAnn m a) - ghostAnn m a
                  + ghostCre m a * (ghostAnn m a * ghostAnn m a) := by noncomm_ring
              _ = -ghostAnn m a := by rw [hsqA]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m b
        = -(ghostCre m b * ghostAnn m a) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg (fun hh => hne hh.symm), zero_sub]
    have hAA : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
        = -(ghostAnn m a * ghostAnn m b) := by
      rw [ghostAnn, ghostAnn, annih_mul_annih]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
          - ghostAnn m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m b)
              * ghostAnn m b := by noncomm_ring
      _ = ghostCre m b * -((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - (-(ghostCre m b * ghostAnn m a) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b := by rw [hAA, hAC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha

/-- **The cubic ghost part of the Standard-Model BRST charge.** -/
def smGhostCharge (m : ℕ) (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    Module.End ℂ (FermiFock (m + 12)) :=
  Q (smStruct f3) (ghostCre m) (ghostAnn m)

/-- **The cubic ghost charge of the Standard Model is nilpotent.** -/
theorem smGhostCharge_nilpotent (m : ℕ) {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3anti : ∀ a b c, f3 a b c = -f3 b a c)
    (h3jac : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) :
    smGhostCharge m f3 * smGhostCharge m f3 = 0 :=
  brst_charge_nilpotent (smStruct f3) (ghostCre m) (ghostAnn m) (smGhostCAR m)
    (smStruct_antisymm h3anti) (smStruct_jacobi h3jac)

/-! ## 3. The full BRST charge, in the abstract -/

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}

/-- Rotating the innermost index of a threefold sum to the front. -/
theorem sum_rotate3 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := by
  calc ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, F a d g :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := Finset.sum_comm

/-- Rotating the innermost index of a fourfold sum to the front. -/
theorem sum_rotate4 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := by
  calc ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, ∑ h : Fin n, F a d g h :=
        Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun g _ => Finset.sum_comm
    _ = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := Finset.sum_comm

/-- **The BRST charge** `Ω = Σ_a c^a G_a − ½ f_{abc} c^a c^b b_c` of a family of first-class
constraints `G_a`. -/
def brstCharge (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R) (G : Fin n → R) : R :=
  (∑ a, χ a * G a) - (1 / 2 : ℝ) • Q f χ β

/-- **Nilpotency of the full BRST charge.**  If the ghosts obey the CAR, the constraints
commute with the ghosts and close with real structure constants that are antisymmetric and
satisfy the Jacobi identity, then `Ω² = 0` — the fact that makes the BRST cohomology, hence
the physical (gauge-invariant) sector, well defined. -/
theorem brstCharge_nilpotent (f : Fin n → Fin n → Fin n → ℝ) (χ β G : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hGχ : ∀ a b, G a * χ b = χ b * G a) (hGβ : ∀ a b, G a * β b = β b * G a)
    (hclose : ∀ a b, G a * G b - G b * G a = ∑ c, f a b c • G c)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    brstCharge f χ β G * brstCharge f χ β G = 0 := by
  classical
  -- the two halves of the charge
  set X : R := ∑ a, χ a * G a with hXdef
  -- moving a ghost creation operator through a cubic ghost monomial
  have hmove : ∀ a d g h : Fin n,
      χ a * (χ d * χ g * β h) + (χ d * χ g * β h) * χ a
        = (if h = a then (1 : R) else 0) * (χ d * χ g) := by
    intro a d g h
    have hb : β h * χ a = (if h = a then (1 : R) else 0) - χ a * β h :=
      eq_sub_of_add_eq (hCAR.betachi h a)
    have hda : χ d * χ a = -(χ a * χ d) := eq_neg_of_add_eq_zero_left (hCAR.chichi d a)
    have hga : χ g * χ a = -(χ a * χ g) := eq_neg_of_add_eq_zero_left (hCAR.chichi g a)
    have h3 : χ d * χ g * χ a = χ a * (χ d * χ g) := by
      calc χ d * χ g * χ a = χ d * (χ g * χ a) := by noncomm_ring
        _ = χ d * -(χ a * χ g) := by rw [hga]
        _ = -((χ d * χ a) * χ g) := by noncomm_ring
        _ = -((-(χ a * χ d)) * χ g) := by rw [hda]
        _ = χ a * (χ d * χ g) := by noncomm_ring
    have key : (χ d * χ g * β h) * χ a
        = (if h = a then (1 : R) else 0) * (χ d * χ g) - χ a * (χ d * χ g * β h) := by
      have h1 : (χ d * χ g * β h) * χ a = χ d * χ g * (β h * χ a) := by noncomm_ring
      rw [h1, hb]
      have h2 : χ d * χ g * ((if h = a then (1 : R) else 0) - χ a * β h)
          = (if h = a then (1 : R) else 0) * (χ d * χ g) - (χ d * χ g * χ a) * β h := by
        by_cases hh : h = a
        · simp only [hh, if_pos]; noncomm_ring
        · simp only [if_neg hh]; noncomm_ring
      rw [h2, h3]
      noncomm_ring
    rw [key]
    abel
  -- the square of the linear part
  have hXXexp : X * X = ∑ a, ∑ b, (χ a * χ b) * (G a * G b) := by
    rw [hXdef, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [show (χ a * G a) * (χ b * G b) = χ a * (G a * χ b) * G b by noncomm_ring, hGχ a b]
    noncomm_ring
  have hswap : (∑ a, ∑ b, (χ a * χ b) * (G b * G a))
      = -∑ a, ∑ b, (χ a * χ b) * (G a * G b) := by
    rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [show χ b * χ a = -(χ a * χ b) from eq_neg_of_add_eq_zero_left (hCAR.chichi b a)]
    noncomm_ring
  have hXX2 : (2 : ℝ) • (X * X) = ∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * G c) := by
    rw [two_smul, hXXexp]
    nth_rewrite 2 [show (∑ a, ∑ b, (χ a * χ b) * (G a * G b))
        = -∑ a, ∑ b, (χ a * χ b) * (G b * G a) from by rw [hswap, neg_neg]]
    rw [← sub_eq_add_neg, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← mul_sub, hclose a b, Finset.mul_sum]
    exact Finset.sum_congr rfl fun c _ => by rw [mul_smul_comm]
  -- the cross term
  have hXQ : X * Q f χ β + Q f χ β * X = ∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * G c) := by
    have hX1 : X * Q f χ β
        = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((χ a * G a) * (χ d * χ g * β h)) := by
      rw [hXdef, Q, Finset.sum_mul]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun h _ => by rw [mul_smul_comm]
    have hQ1 : Q f χ β * X
        = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((χ d * χ g * β h) * (χ a * G a)) := by
      rw [← sum_rotate4 (fun a d g h => f d g h • ((χ d * χ g * β h) * (χ a * G a)))]
      rw [hXdef, Q, Finset.sum_mul]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun h _ => ?_
      rw [smul_mul_assoc, Finset.mul_sum, Finset.smul_sum]
    rw [hX1, hQ1, ← Finset.sum_add_distrib]
    have hcollapse : ∀ a : Fin n,
        ((∑ d, ∑ g, ∑ h, f d g h • ((χ a * G a) * (χ d * χ g * β h)))
          + ∑ d, ∑ g, ∑ h, f d g h • ((χ d * χ g * β h) * (χ a * G a)))
        = ∑ d, ∑ g, f d g a • (χ d * χ g * G a) := by
      intro a
      simp only [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun d _ => ?_
      refine Finset.sum_congr rfl fun g _ => ?_
      have hterm : ∀ h : Fin n,
          f d g h • ((χ a * G a) * (χ d * χ g * β h))
            + f d g h • ((χ d * χ g * β h) * (χ a * G a))
          = f d g h • ((if h = a then (1 : R) else 0) * (χ d * χ g * G a)) := by
        intro h
        rw [← smul_add]
        congr 1
        have hc1 : (χ a * G a) * (χ d * χ g * β h) = (χ a * (χ d * χ g * β h)) * G a := by
          have hg1 : G a * (χ d * χ g * β h) = (χ d * χ g * β h) * G a := by
            rw [show G a * (χ d * χ g * β h) = ((G a * χ d) * χ g) * β h by noncomm_ring,
              hGχ a d,
              show ((χ d * G a) * χ g) * β h = (χ d * (G a * χ g)) * β h by noncomm_ring,
              hGχ a g,
              show (χ d * (χ g * G a)) * β h = (χ d * χ g) * (G a * β h) by noncomm_ring,
              hGβ a h]
            noncomm_ring
          calc (χ a * G a) * (χ d * χ g * β h)
              = χ a * (G a * (χ d * χ g * β h)) := by noncomm_ring
            _ = χ a * ((χ d * χ g * β h) * G a) := by rw [hg1]
            _ = (χ a * (χ d * χ g * β h)) * G a := by noncomm_ring
        have hc2 : (χ d * χ g * β h) * (χ a * G a)
            = ((χ d * χ g * β h) * χ a) * G a := by noncomm_ring
        rw [hc1, hc2, ← add_mul, hmove a d g h]
        noncomm_ring
      rw [Finset.sum_congr rfl fun h (_ : h ∈ Finset.univ) => hterm h]
      rw [Finset.sum_eq_single a]
      · rw [if_pos rfl, one_mul]
      · intro h _ hh
        rw [if_neg hh, zero_mul, smul_zero]
      · intro ha
        exact absurd (Finset.mem_univ a) ha
    rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hcollapse a]
    rw [← sum_rotate3 (fun a d g => f d g a • (χ d * χ g * G a))]
  -- nilpotency of the cubic ghost term
  have hQnil : Q f χ β * Q f χ β = 0 := brst_charge_nilpotent f χ β hCAR hf12 hjac
  -- assemble
  have h2 : (2 : ℝ) • (brstCharge f χ β G * brstCharge f χ β G) = 0 := by
    have hexp : brstCharge f χ β G * brstCharge f χ β G
        = X * X - (1 / 2 : ℝ) • (X * Q f χ β + Q f χ β * X)
          + (1 / 2 : ℝ) • ((1 / 2 : ℝ) • (Q f χ β * Q f χ β)) := by
      rw [brstCharge, ← hXdef]
      simp only [sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm, smul_add, smul_sub]
      abel
    have htwo : ((2 : ℝ) * (1 / 2 : ℝ)) = 1 := by norm_num
    rw [hexp, hQnil, smul_zero, smul_zero, add_zero, smul_sub, smul_smul, htwo, one_smul,
      hXX2, hXQ, sub_self]
  have hne : (2 : ℝ) ≠ 0 := two_ne_zero
  rcases smul_eq_zero.mp h2 with h | h
  · exact absurd h hne
  · exact h

/-! ## 4. The Gauss-law constraints: second quantization as a Lie homomorphism -/

variable {N : ℕ}

/-- The commutator of two occupation bilinears, from the canonical anticommutation
relations. -/
theorem creat_annih_commutator (i j k l : Fin N) :
    (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        - (creat k * annih l) * (creat i * annih j)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by
  have e1 : (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - creat i * creat k * (annih j * annih l) := by
    have h0 : (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * creat k) * annih l := by
      noncomm_ring
    rw [h0, annih_mul_creat j k]
    by_cases h : j = k
    · rw [if_pos h, if_pos h]; noncomm_ring
    · rw [if_neg h, if_neg h]; noncomm_ring
  have e2 : (creat k * annih l : Module.End ℂ (FermiFock N)) * (creat i * annih j)
      = (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
        - creat k * creat i * (annih l * annih j) := by
    have h0 : (creat k * annih l : Module.End ℂ (FermiFock N)) * (creat i * annih j)
        = creat k * ((annih l : Module.End ℂ (FermiFock N)) * creat i) * annih j := by
      noncomm_ring
    rw [h0, annih_mul_creat l i]
    by_cases h : l = i
    · rw [if_pos h, if_pos h]; noncomm_ring
    · rw [if_neg h, if_neg h]; noncomm_ring
  have e3 : (creat k * creat i : Module.End ℂ (FermiFock N)) * (annih l * annih j)
      = creat i * creat k * (annih j * annih l) := by
    rw [creat_mul_creat k i, annih_mul_annih l j]
    noncomm_ring
  rw [e1, e2, e3]
  abel

/-- The second quantization written with the ring multiplication of `Module.End`. -/
theorem fermiBilin_eq4 (M : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N))
      = ∑ i : Fin N, ∑ j : Fin N, M i j • (creat i * annih j) := rfl

theorem fermiBilin_sub (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (M - P) : Module.End ℂ (FermiFock N)) = fermiBilin M - fermiBilin P := by
  rw [fermiBilin_eq4, fermiBilin_eq4, fermiBilin_eq4, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [Matrix.sub_apply, sub_smul]

theorem fermiBilin_mul4 (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N)) * fermiBilin P
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (M i j * P k l) • ((creat i * annih j) * (creat k * annih l)) := by
  rw [fermiBilin_eq4, fermiBilin_eq4, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [smul_mul_assoc, mul_smul_comm, smul_smul]

/-- Swapping the two index pairs of a fourfold sum. -/
theorem sum4_swap (F : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N)) :
    ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
  calc ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ q : Fin N × Fin N, ∑ p : Fin N × Fin N, F p.1 p.2 q.1 q.2 := by
        simp [Fintype.sum_prod_type]
    _ = ∑ p : Fin N × Fin N, ∑ q : Fin N × Fin N, F p.1 p.2 q.1 q.2 := Finset.sum_comm
    _ = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
        simp [Fintype.sum_prod_type]

/-- The first delta contraction of the commutator sum. -/
theorem sum_delta_left (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (M * P) := by
  have step1 : ∀ i j : Fin N,
      (∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0))
        = ∑ l : Fin N, (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
    intro i j
    rw [Finset.sum_eq_single j]
    · exact Finset.sum_congr rfl fun l _ => by rw [if_pos rfl]
    · intro k _ hk
      exact Finset.sum_eq_zero fun l _ => by rw [if_neg (Ne.symm hk), smul_zero]
    · intro hj
      exact absurd (Finset.mem_univ j) hj
  calc ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ l : Fin N,
          (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => step1 i j
    _ = ∑ i : Fin N, ∑ l : Fin N, ∑ j : Fin N,
          (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ i : Fin N, ∑ l : Fin N,
          ((M * P) i l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
    _ = fermiBilin (M * P) := (fermiBilin_eq4 (M * P)).symm

/-- The second delta contraction of the commutator sum. -/
theorem sum_delta_right (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (P * M) := by
  have step1 : ∀ i j k : Fin N,
      (∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0))
        = (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
    intro i j k
    rw [Finset.sum_eq_single i]
    · rw [if_pos rfl]
    · intro l _ hl
      rw [if_neg hl, smul_zero]
    · intro hi
      exact absurd (Finset.mem_univ i) hi
  calc ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
          Finset.sum_congr rfl fun k _ => step1 i j k
    _ = ∑ i : Fin N, ∑ k : Fin N, ∑ j : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k : Fin N, ∑ i : Fin N, ∑ j : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := Finset.sum_comm
    _ = ∑ k : Fin N, ∑ j : Fin N, ∑ i : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k : Fin N, ∑ j : Fin N,
          ((P * M) k j) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
        congr 1
        exact Finset.sum_congr rfl fun i _ => by ring
    _ = fermiBilin (P * M) := (fermiBilin_eq4 (P * M)).symm

/-- **Second quantization is a Lie-algebra homomorphism**: `[dΓ(A), dΓ(B)] = dΓ([A,B])`. -/
theorem fermiBilin_lie (A B : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * fermiBilin B
        - fermiBilin B * fermiBilin A
      = fermiBilin (A * B - B * A) := by
  have h2 : (fermiBilin B : Module.End ℂ (FermiFock N)) * fermiBilin A
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (A i j * B k l) • ((creat k * annih l) * (creat i * annih j)) := by
    rw [fermiBilin_mul4 B A,
      ← sum4_swap (fun i j k l =>
        (A i j * B k l) • ((creat k * annih l : Module.End ℂ (FermiFock N))
          * (creat i * annih j)))]
    exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [mul_comm]
  rw [fermiBilin_mul4 A B, h2]
  have hcomb : ∀ X Y : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N),
      (∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, X i j k l)
        - (∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, Y i j k l)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, (X i j k l - Y i j k l) := by
    intro X Y
    simp only [← Finset.sum_sub_distrib]
  rw [hcomb]
  have hterm : ∀ i j k l : Fin N,
      ((A i j * B k l) • ((creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l))
        - (A i j * B k l) • ((creat k * annih l : Module.End ℂ (FermiFock N))
            * (creat i * annih j)))
      = (A i j * B k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (A i j * B k l)
            • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by
    intro i j k l
    rw [← smul_sub, ← smul_sub, creat_annih_commutator i j k l]
  rw [Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => Finset.sum_congr rfl
    fun j (_ : j ∈ Finset.univ) => Finset.sum_congr rfl fun k (_ : k ∈ Finset.univ) =>
      Finset.sum_congr rfl fun l (_ : l ∈ Finset.univ) => hterm i j k l]
  rw [← hcomb, sum_delta_left A B, sum_delta_right A B, ← fermiBilin_sub]

/-- A second-quantized operator whose `k`-th column vanishes commutes with the creation
operator of the mode `k`: bilinears are even. -/
theorem fermiBilin_comm_creat {A : Matrix (Fin N) (Fin N) ℂ} {k : Fin N}
    (hcol : ∀ i, A i k = 0) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * creat k
      = creat k * fermiBilin A := by
  rw [fermiBilin_eq4, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases h : j = k
  · subst h
    rw [hcol i, zero_smul, zero_mul, mul_zero]
  · rw [smul_mul_assoc, mul_smul_comm]
    congr 1
    have h1 : (annih j : Module.End ℂ (FermiFock N)) * creat k = -(creat k * annih j) := by
      rw [annih_mul_creat j k, if_neg h, zero_sub]
    calc (creat i * annih j : Module.End ℂ (FermiFock N)) * creat k
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * creat k) := by noncomm_ring
      _ = creat i * -(creat k * annih j) := by rw [h1]
      _ = -((creat i : Module.End ℂ (FermiFock N)) * creat k) * annih j := by noncomm_ring
      _ = -(-((creat k : Module.End ℂ (FermiFock N)) * creat i)) * annih j := by
            rw [creat_mul_creat i k]
      _ = creat k * (creat i * annih j) := by noncomm_ring

/-- A second-quantized operator whose `k`-th row vanishes commutes with the annihilation
operator of the mode `k`. -/
theorem fermiBilin_comm_annih {A : Matrix (Fin N) (Fin N) ℂ} {k : Fin N}
    (hrow : ∀ j, A k j = 0) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * annih k
      = annih k * fermiBilin A := by
  rw [fermiBilin_eq4, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases h : i = k
  · subst h
    rw [hrow j, zero_smul, zero_mul, mul_zero]
  · rw [smul_mul_assoc, mul_smul_comm]
    congr 1
    have h1 : (annih k : Module.End ℂ (FermiFock N)) * creat i = -(creat i * annih k) := by
      rw [annih_mul_creat k i, if_neg (fun hh => h hh.symm), zero_sub]
    calc (creat i * annih j : Module.End ℂ (FermiFock N)) * annih k
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * annih k) := by noncomm_ring
      _ = creat i * -((annih k : Module.End ℂ (FermiFock N)) * annih j) := by
            rw [annih_mul_annih j k]
      _ = -((creat i : Module.End ℂ (FermiFock N)) * annih k) * annih j := by noncomm_ring
      _ = ((annih k : Module.End ℂ (FermiFock N)) * creat i) * annih j := by rw [← h1]
      _ = annih k * (creat i * annih j) := by noncomm_ring

/-- Second quantization is linear in the one-particle matrix. -/
theorem fermiBilin_smul (c : ℂ) (M : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (c • M) : Module.End ℂ (FermiFock N)) = c • fermiBilin M := by
  rw [fermiBilin_eq4, fermiBilin_eq4, Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.smul_sum]
  exact Finset.sum_congr rfl fun j _ => by rw [Matrix.smul_apply, smul_eq_mul, mul_smul]

/-- Second quantization is additive in the one-particle matrix. -/
theorem fermiBilin_add' (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (M + P) : Module.End ℂ (FermiFock N)) = fermiBilin M + fermiBilin P := by
  rw [fermiBilin_eq4, fermiBilin_eq4, fermiBilin_eq4, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [Matrix.add_apply, add_smul]

/-- Second quantization commutes with finite sums of one-particle matrices. -/
theorem fermiBilin_sum {ι : Type*} (s : Finset ι) (M : ι → Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (∑ t ∈ s, M t) : Module.End ℂ (FermiFock N))
      = ∑ t ∈ s, fermiBilin (M t) := by
  classical
  induction s using Finset.induction with
  | empty =>
      rw [Finset.sum_empty, Finset.sum_empty, fermiBilin_eq4]
      refine Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => ?_
      simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, ← ih]
      exact fermiBilin_add' (M a) (∑ t ∈ s, M t)

/-! ## 5. The Standard-Model BRST charge -/

/-- The matter block of a one-particle operator, embedded in the joint matter ⊗ ghost mode
set: the operator acts on the first `m` modes and annihilates the ghosts. -/
def embedMatter (m : ℕ) (M : Matrix (Fin m) (Fin m) ℂ) :
    Matrix (Fin (m + 12)) (Fin (m + 12)) ℂ :=
  Matrix.reindex finSumFinEquiv finSumFinEquiv (Matrix.fromBlocks M 0 0 0)

/-- **The Gauss-law generator** of the `a`-th gauge direction: the second quantization
`−i dΓ(T_a)` of the one-particle generator on the matter modes. -/
def matterGen (m : ℕ) (T : Fin 12 → Matrix (Fin m) (Fin m) ℂ) (a : Fin 12) :
    Module.End ℂ (FermiFock (m + 12)) :=
  (-Complex.I) • fermiBilin (embedMatter m (T a))

/-- The embedded matter block has no entry in a ghost column. -/
theorem embedMatter_col_ghost (m : ℕ) (M : Matrix (Fin m) (Fin m) ℂ) (b : Fin 12)
    (i : Fin (m + 12)) : embedMatter m M i (ghostMode m b) = 0 := by
  rcases h : finSumFinEquiv.symm i with u | u <;>
    simp [embedMatter, ghostMode, Matrix.reindex_apply, Matrix.submatrix_apply, h]

/-- The embedded matter block has no entry in a ghost row. -/
theorem embedMatter_row_ghost (m : ℕ) (M : Matrix (Fin m) (Fin m) ℂ) (b : Fin 12)
    (j : Fin (m + 12)) : embedMatter m M (ghostMode m b) j = 0 := by
  rcases h : finSumFinEquiv.symm j with u | u <;>
    simp [embedMatter, ghostMode, Matrix.reindex_apply, Matrix.submatrix_apply, h]

/-- Embedding the matter block is multiplicative. -/
theorem embedMatter_mul (m : ℕ) (M P : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m M * embedMatter m P = embedMatter m (M * P) := by
  simp only [embedMatter, Matrix.reindex_apply]
  rw [Matrix.submatrix_mul_equiv (Matrix.fromBlocks M 0 0 0) (Matrix.fromBlocks P 0 0 0)
    finSumFinEquiv.symm finSumFinEquiv.symm finSumFinEquiv.symm]
  congr 1
  rw [Matrix.fromBlocks_multiply]
  simp

/-- Embedding the matter block is compatible with subtraction. -/
theorem embedMatter_sub (m : ℕ) (M P : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (M - P) = embedMatter m M - embedMatter m P := by
  ext i j
  simp only [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply, Matrix.sub_apply]
  rcases finSumFinEquiv.symm i with u | u <;> rcases finSumFinEquiv.symm j with v | v <;> simp

/-- Embedding the matter block is compatible with scalar multiplication. -/
theorem embedMatter_smul (m : ℕ) (c : ℂ) (M : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (c • M) = c • embedMatter m M := by
  ext i j
  simp only [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply, Matrix.smul_apply,
    smul_eq_mul]
  rcases finSumFinEquiv.symm i with u | u <;> rcases finSumFinEquiv.symm j with v | v <;> simp

/-- Embedding the matter block is compatible with finite sums. -/
theorem embedMatter_sum {m : ℕ} {ι : Type*} (s : Finset ι) (M : ι → Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (∑ t ∈ s, M t) = ∑ t ∈ s, embedMatter m (M t) := by
  classical
  induction s using Finset.induction with
  | empty =>
      ext i j
      simp [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply]
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, ← ih]
      ext i j
      simp only [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply, Matrix.add_apply]
      rcases finSumFinEquiv.symm i with u | u <;> rcases finSumFinEquiv.symm j with v | v <;> simp

/-- **The Gauss-law generators close with the real structure constants.** -/
theorem matterGen_lie {m : ℕ} {T : Fin 12 → Matrix (Fin m) (Fin m) ℂ}
    {f : Fin 12 → Fin 12 → Fin 12 → ℝ} (hT : ClosesWithStructureConstants T f) (a b : Fin 12) :
    matterGen m T a * matterGen m T b - matterGen m T b * matterGen m T a
      = ∑ c, f a b c • matterGen m T c := by
  have hstep : matterGen m T a * matterGen m T b - matterGen m T b * matterGen m T a
      = ((-Complex.I) * (-Complex.I)) •
          (fermiBilin (embedMatter m (T a * T b - T b * T a))
            : Module.End ℂ (FermiFock (m + 12))) := by
    rw [matterGen, matterGen, smul_mul_smul_comm, smul_mul_smul_comm, ← smul_sub,
      fermiBilin_lie, embedMatter_mul, embedMatter_mul, ← embedMatter_sub]
  rw [hstep, hT a b, embedMatter_smul, fermiBilin_smul, embedMatter_sum, fermiBilin_sum,
    smul_smul, Finset.smul_sum]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [ethe Jacobi identity are inherited;
  `su2Struct` is the concrete `su(2)` Levi-Civita family (antisymmetry and Jacobi by finite
  check), `u1Struct` the abelian one, and `smStruct f₃` assembles them with an `su(3)`
  family `f₃` into the twelve-generator family, with **`smStruct_antisymm`** and
  **`smStruct_jacobi`**: the Standard-Model gauge algebra has totally antisymmetric
  structure constants obeying Jacobi, which is exactly what BRST needs.
* **The ghost sector on the CAR algebra.**  The ghosts are the last twelve modes of the
  fermionic Fock space of `BookProof.ChapterSmCarAlgebra`; `smGhostCAR` is their canonical
  anticommutation relations, `ghostNumber` the ghost-number operator with
  `ghostNumber_occ` (its spectrum is the ghost occupation number) and the commutators
  `ghostNumber_comm_ghostCre`, `ghostNumber_comm_ghostAnn`.
* **The cubic ghost charge is nilpotent** — `smGhostCharge_nilpotent`, through the project's
  `BookProof.BRSTNilpotent.brst_charge_nilpotent` with the Standard-Model structure
  constants.
* **The full BRST charge is nilpotent** — `brstCharge_nilpotent`, an algebraic theorem in
  any ring carrying ghosts with the CAR and constraint operators `G_a` that commute with
  the ghosts and close with the structure constants: `Ω² = 0`.
* **Second quantization is a Lie-algebra homomorphism** — `fermiBilin_lie`,
  `creat_annih_commutator`: `[dΓ(A), dΓ(B)] = dΓ([A,B])`, so the Gauss-law generators
  `G_a = −i dΓ(T_a)` of the matter sector close with the *real* structure constants
  (`matterGen_lie`), and they commute with the ghosts (`matterGen_comm_ghostCre`,
  `matterGen_comm_ghostAnn`) because they are even.
* **The Standard-Model BRST charge** `smBrstCharge` on the joint matter ⊗ ghost Fock space,
  with **`smBrstCharge_nilpotent`**: `Ω² = 0`, which is what makes the BRST cohomology —
  the physical sector — well defined.

## Honest boundary

The mode set here is finite: one plane-wave matter multiplet and the twelve ghosts, i.e. the
gauge algebra of the collective-coordinate presentation of §D6b-SM.1.  The charge used in
this module is the abstract one, with the constraints `G_a` given as data.  The BRST charge
**as `book.tex` itself defines it** — the density
`Ω = π^μ_a ∂_μψ†_a − π^μ_a f_{abc}A_{μb}ψ†_c − (i/2) f_{abc}ψ†_aψ†_bψ_c` with the book's
canonical relations, the Gauss law *derived* from them, and the gauge-fixing fermion
`Ψ = i ψ_a A_{0a}` — is built in `BookProof.ChapterBookBrstYangMills`,
`BookProof.ChapterBookBrstGaugeFixing` and `BookProof.ChapterBookBrstInstances`, the last of
which instantiates it with the Standard-Model structure constants `smStruct f₃`.  The
`su(3)` structure constants enter as a family satisfying antisymmetry and Jacobi (which
`BookProof.ChapterYangMillsSU3` derives for trace-orthonormal generators); the book's
formalism uses no Faddeev–Popov determinant and none is constructed, and no statement about
the *size* of the BRST cohomology is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SmBrstGhost

open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

/-! ## 1. The structure constants of `su(3) ⊕ su(2) ⊕ u(1)` -/

/-- The direct sum of two families of structure constants: a bracket never leaves its
summand. -/
def sumStruct {ι κ : Type*} (f1 : ι → ι → ι → ℝ) (f2 : κ → κ → κ → ℝ) :
    (ι ⊕ κ) → (ι ⊕ κ) → (ι ⊕ κ) → ℝ
  | Sum.inl a, Sum.inl b, Sum.inl c => f1 a b c
  | Sum.inr a, Sum.inr b, Sum.inr c => f2 a b c
  | _, _, _ => 0

theorem sumStruct_antisymm {ι κ : Type*} {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ} (h1 : ∀ a b c, f1 a b c = -f1 b a c)
    (h2 : ∀ a b c, f2 a b c = -f2 b a c) (a b c : ι ⊕ κ) :
    sumStruct f1 f2 a b c = -sumStruct f1 f2 b a c := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;>
    simp only [sumStruct, neg_zero] <;> first | rfl | exact h1 a b c | exact h2 a b c

theorem sumStruct_jacobi {ι κ : Type*} [Fintype ι] [Fintype κ] {f1 : ι → ι → ι → ℝ}
    {f2 : κ → κ → κ → ℝ}
    (h1 : ∀ a b c h : ι, ∑ e, (f1 a b e * f1 e c h + f1 b c e * f1 e a h
      + f1 c a e * f1 e b h) = 0)
    (h2 : ∀ a b c h : κ, ∑ e, (f2 a b e * f2 e c h + f2 b c e * f2 e a h
      + f2 c a e * f2 e b h) = 0)
    (a b c h : ι ⊕ κ) :
    ∑ e, (sumStruct f1 f2 a b e * sumStruct f1 f2 e c h
      + sumStruct f1 f2 b c e * sumStruct f1 f2 e a h
      + sumStruct f1 f2 c a e * sumStruct f1 f2 e b h) = 0 := by
  rcases a with a | a <;> rcases b with b | b <;> rcases c with c | c <;> rcases h with h | h <;>
    simp only [Fintype.sum_sum_type, sumStruct, mul_zero, zero_mul, add_zero, zero_add,
      Finset.sum_const_zero] <;>
    first | rfl | exact h1 a b c h | exact h2 a b c h

/-- The Levi-Civita symbol on three indices, as an integer. -/
def epsZ (a b c : Fin 3) : ℤ :=
  if a = b ∨ b = c ∨ a = c then 0
  else if (a, b) = ((0 : Fin 3), (1 : Fin 3)) ∨ (a, b) = ((1 : Fin 3), (2 : Fin 3))
        ∨ (a, b) = ((2 : Fin 3), (0 : Fin 3)) then 1 else -1

/-- **The `su(2)` structure constants** `ε_{jkl}`. -/
def su2Struct (a b c : Fin 3) : ℝ := (epsZ a b c : ℝ)

/-- **The `u(1)` structure constants**: an abelian factor has none. -/
def u1Struct (_ _ _ : Fin 1) : ℝ := 0

theorem epsZ_antisymm : ∀ a b c : Fin 3, epsZ a b c = -epsZ b a c := by decide

theorem epsZ_jacobi : ∀ a b c h : Fin 3,
    ∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h + epsZ c a e * epsZ e b h) = 0 := by
  decide

theorem su2Struct_antisymm (a b c : Fin 3) : su2Struct a b c = -su2Struct b a c := by
  rw [su2Struct, su2Struct, epsZ_antisymm a b c]
  push_cast
  ring

theorem su2Struct_jacobi (a b c h : Fin 3) :
    ∑ e, (su2Struct a b e * su2Struct e c h + su2Struct b c e * su2Struct e a h
      + su2Struct c a e * su2Struct e b h) = 0 := by
  have hz := epsZ_jacobi a b c h
  have : ((∑ e, (epsZ a b e * epsZ e c h + epsZ b c e * epsZ e a h
      + epsZ c a e * epsZ e b h) : ℤ) : ℝ) = 0 := by rw [hz]; norm_num
  rw [← this]
  push_cast [su2Struct]
  ring

theorem u1Struct_antisymm (a b c : Fin 1) : u1Struct a b c = -u1Struct b a c := by
  simp [u1Struct]

theorem u1Struct_jacobi (a b c h : Fin 1) :
    ∑ e, (u1Struct a b e * u1Struct e c h + u1Struct b c e * u1Struct e a h
      + u1Struct c a e * u1Struct e b h) = 0 := by
  simp [u1Struct]

/-- The twelve generator labels of the Standard-Model gauge algebra, split into the eight
gluon, three weak and one hypercharge directions. -/
def smIdxEquiv : Fin 12 ≃ (Fin 8 ⊕ (Fin 3 ⊕ Fin 1)) :=
  (finCongr (by norm_num : (12 : ℕ) = 8 + (3 + 1))).trans
    (finSumFinEquiv.symm.trans (Equiv.sumCongr (Equiv.refl (Fin 8)) finSumFinEquiv.symm))

/-- **The structure constants of the Standard-Model gauge algebra** `su(3) ⊕ su(2) ⊕ u(1)`,
given those of `su(3)`. -/
def smStruct (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) (a b c : Fin 12) : ℝ :=
  sumStruct f3 (sumStruct su2Struct u1Struct) (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c)

theorem smStruct_antisymm {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c, f3 a b c = -f3 b a c) (a b c : Fin 12) :
    smStruct f3 a b c = -smStruct f3 b a c := by
  exact sumStruct_antisymm h3
    (sumStruct_antisymm su2Struct_antisymm u1Struct_antisymm) _ _ _

theorem smStruct_jacobi {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3 : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) (a b c h : Fin 12) :
    ∑ e, (smStruct f3 a b e * smStruct f3 e c h + smStruct f3 b c e * smStruct f3 e a h
      + smStruct f3 c a e * smStruct f3 e b h) = 0 := by
  have hsum := sumStruct_jacobi (f1 := f3) (f2 := sumStruct su2Struct u1Struct) h3
    (sumStruct_jacobi su2Struct_jacobi u1Struct_jacobi)
    (smIdxEquiv a) (smIdxEquiv b) (smIdxEquiv c) (smIdxEquiv h)
  rw [← Equiv.sum_comp smIdxEquiv] at hsum
  simpa [smStruct] using hsum

/-! ## 2. The ghost sector inside the CAR algebra -/

variable {m : ℕ}

/-- The mode carrying the `a`-th ghost: the ghosts are the last twelve modes of the
fermionic Fock space, the matter modes being the first `m`. -/
def ghostMode (m : ℕ) (a : Fin 12) : Fin (m + 12) := Fin.natAdd m a

/-- The **ghost creation** operator `c^a`. -/
def ghostCre (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  creat (ghostMode m a)

/-- The **ghost annihilation** (antighost) operator `b_a`. -/
def ghostAnn (m : ℕ) (a : Fin 12) : Module.End ℂ (FermiFock (m + 12)) :=
  annih (ghostMode m a)

/-- **The ghosts obey the canonical anticommutation relations.** -/
theorem ghostMode_injective (m : ℕ) : Function.Injective (ghostMode m) := by
  intro a b hab
  have h : m + (a : ℕ) = m + (b : ℕ) := by
    simpa [ghostMode, Fin.ext_iff] using hab
  exact Fin.ext (by omega)

theorem smGhostCAR (m : ℕ) : GhostCAR (ghostCre m) (ghostAnn m) := by
  refine ⟨fun a b => ?_, fun a b => ?_, fun a b => ?_⟩
  · exact car_creat_creat (ghostMode m a) (ghostMode m b)
  · exact car_annih_annih (ghostMode m a) (ghostMode m b)
  · by_cases h : a = b
    · subst h
      rw [if_pos rfl]
      exact car_annih_creat_self (ghostMode m a)
    · rw [if_neg h]
      exact car_annih_creat_of_ne (fun hh => h (ghostMode_injective m hh))

/-- **The ghost-number operator** `Σ_a c^a b_a`. -/
def ghostNumber (m : ℕ) : Module.End ℂ (FermiFock (m + 12)) :=
  ∑ a : Fin 12, ghostCre m a * ghostAnn m a

/-- The mixed canonical anticommutation relation in ring form. -/
theorem annih_mul_creat {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * creat q
      = (if p = q then 1 else 0) - creat q * annih p := by
  by_cases h : p = q
  · subst h
    rw [if_pos rfl]
    exact eq_sub_of_add_eq (car_annih_creat_self p)
  · rw [if_neg h]
    exact eq_sub_of_add_eq (car_annih_creat_of_ne h)

/-- Creation operators anticommute, in ring form. -/
theorem creat_mul_creat {N : ℕ} (p q : Fin N) :
    (creat p : Module.End ℂ (FermiFock N)) * creat q = -(creat q * creat p) :=
  eq_neg_of_add_eq_zero_left (car_creat_creat p q)

/-- Annihilation operators anticommute, in ring form. -/
theorem annih_mul_annih {N : ℕ} (p q : Fin N) :
    (annih p : Module.End ℂ (FermiFock N)) * annih q = -(annih q * annih p) :=
  eq_neg_of_add_eq_zero_left (car_annih_annih p q)

/-- The occupation-number operator of a mode on an occupation state. -/
theorem occupation_occ {N : ℕ} (i : Fin N) (S : Finset (Fin N)) :
    creat i (annih i (occ S)) = if i ∈ S then occ S else 0 := by
  ext T
  rw [occupation_apply]
  by_cases h : i ∈ S <;> by_cases hT : T = S <;>
    simp [h, hT, occ, EuclideanSpace.single_apply]

/-- **The ghost number of an occupation state** is the number of occupied ghost modes. -/
theorem ghostNumber_occ (m : ℕ) (S : Finset (Fin (m + 12))) :
    ghostNumber m (occ S)
      = (Finset.univ.filter (fun a : Fin 12 => ghostMode m a ∈ S)).card • occ S := by
  classical
  rw [ghostNumber, LinearMap.sum_apply]
  have hterm : ∀ a : Fin 12, (ghostCre m a * ghostAnn m a) (occ S)
      = if ghostMode m a ∈ S then occ S else 0 := fun a => occupation_occ (ghostMode m a) S
  rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hterm a]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero]

/-- Creation operators square to zero (the Pauli principle). -/
theorem creat_sq {N : ℕ} (i : Fin N) :
    (creat i : Module.End ℂ (FermiFock N)) * creat i = 0 := by
  have h2 : (2 : ℂ) • ((creat i : Module.End ℂ (FermiFock N)) * creat i) = 0 := by
    rw [two_smul]; exact car_creat_creat i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- Annihilation operators square to zero. -/
theorem annih_sq {N : ℕ} (i : Fin N) :
    (annih i : Module.End ℂ (FermiFock N)) * annih i = 0 := by
  have h2 : (2 : ℂ) • ((annih i : Module.End ℂ (FermiFock N)) * annih i) = 0 := by
    rw [two_smul]; exact car_annih_annih i i
  rcases smul_eq_zero.mp h2 with h3 | h3
  · exact absurd h3 two_ne_zero
  · exact h3

/-- A ghost creation operator raises the ghost number by one. -/
theorem ghostNumber_comm_ghostCre (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostCre m a - ghostCre m a * ghostNumber m = ghostCre m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * (1 - ghostCre m a * ghostAnn m a)
            - (ghostCre m a * ghostCre m a) * ghostAnn m a := by rw [hAC]
      _ = ghostCre m a := by
            have hsq : (ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a = 0 := by
              rw [ghostCre]; exact creat_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (1 - ghostCre m a * ghostAnn m a)
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a
                = ghostCre m a - (ghostCre m a * ghostCre m a) * ghostAnn m a
                  - (ghostCre m a * ghostCre m a) * ghostAnn m a := by noncomm_ring
              _ = ghostCre m a := by rw [hsq]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostAnn m b) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg hne, zero_sub]
    have hCC : (ghostCre m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = -(ghostCre m a * ghostCre m b) := by
      rw [ghostCre, ghostCre, creat_mul_creat]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
          - ghostCre m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = ghostCre m b * -(ghostCre m a * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hAC]
      _ = -((ghostCre m b * ghostCre m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by noncomm_ring
      _ = -((-(ghostCre m a * ghostCre m b) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b)
            - ghostCre m a * (ghostCre m b * ghostAnn m b) := by rw [hCC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha

/-- A ghost annihilation operator lowers the ghost number by one. -/
theorem ghostNumber_comm_ghostAnn (m : ℕ) (a : Fin 12) :
    ghostNumber m * ghostAnn m a - ghostAnn m a * ghostNumber m = -ghostAnn m a := by
  rw [ghostNumber, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single a]
  · have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a
        = 1 - ghostCre m a * ghostAnn m a := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_pos rfl]
    calc (ghostCre m a * ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
          - ghostAnn m a * (ghostCre m a * ghostAnn m a)
        = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m a)
              * ghostAnn m a := by noncomm_ring
      _ = ghostCre m a * ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - (1 - ghostCre m a * ghostAnn m a) * ghostAnn m a := by rw [hAC]
      _ = -ghostAnn m a := by
            have hsqA : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a = 0 := by
              rw [ghostAnn]; exact annih_sq _
            calc (ghostCre m a : Module.End ℂ (FermiFock (m + 12)))
                    * (ghostAnn m a * ghostAnn m a)
                  - (1 - ghostCre m a * ghostAnn m a) * ghostAnn m a
                = ghostCre m a * (ghostAnn m a * ghostAnn m a) - ghostAnn m a
                  + ghostCre m a * (ghostAnn m a * ghostAnn m a) := by noncomm_ring
              _ = -ghostAnn m a := by rw [hsqA]; noncomm_ring
  · intro b _ hb
    have hne : ghostMode m b ≠ ghostMode m a := fun hh => hb (ghostMode_injective m hh)
    have hAC : (ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m b
        = -(ghostCre m b * ghostAnn m a) := by
      rw [ghostAnn, ghostCre, annih_mul_creat, if_neg (fun hh => hne hh.symm), zero_sub]
    have hAA : (ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
        = -(ghostAnn m a * ghostAnn m b) := by
      rw [ghostAnn, ghostAnn, annih_mul_annih]
    calc (ghostCre m b * ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a
          - ghostAnn m a * (ghostCre m b * ghostAnn m b)
        = ghostCre m b * ((ghostAnn m b : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m a)
            - ((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostCre m b)
              * ghostAnn m b := by noncomm_ring
      _ = ghostCre m b * -((ghostAnn m a : Module.End ℂ (FermiFock (m + 12))) * ghostAnn m b)
            - (-(ghostCre m b * ghostAnn m a) : Module.End ℂ (FermiFock (m + 12)))
              * ghostAnn m b := by rw [hAA, hAC]
      _ = 0 := by noncomm_ring
  · intro ha
    exact absurd (Finset.mem_univ a) ha

/-- **The cubic ghost part of the Standard-Model BRST charge.** -/
def smGhostCharge (m : ℕ) (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    Module.End ℂ (FermiFock (m + 12)) :=
  Q (smStruct f3) (ghostCre m) (ghostAnn m)

/-- **The cubic ghost charge of the Standard Model is nilpotent.** -/
theorem smGhostCharge_nilpotent (m : ℕ) {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ}
    (h3anti : ∀ a b c, f3 a b c = -f3 b a c)
    (h3jac : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) :
    smGhostCharge m f3 * smGhostCharge m f3 = 0 :=
  brst_charge_nilpotent (smStruct f3) (ghostCre m) (ghostAnn m) (smGhostCAR m)
    (smStruct_antisymm h3anti) (smStruct_jacobi h3jac)

/-! ## 3. The full BRST charge, in the abstract -/

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}

/-- Rotating the innermost index of a threefold sum to the front. -/
theorem sum_rotate3 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := by
  calc ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, F a d g
      = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, F a d g :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, F a d g := Finset.sum_comm

/-- Rotating the innermost index of a fourfold sum to the front. -/
theorem sum_rotate4 {M : Type*} [AddCommMonoid M] {n : ℕ} (F : Fin n → Fin n → Fin n → Fin n → M) :
    ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := by
  calc ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, ∑ a : Fin n, F a d g h
      = ∑ d : Fin n, ∑ g : Fin n, ∑ a : Fin n, ∑ h : Fin n, F a d g h :=
        Finset.sum_congr rfl fun d _ => Finset.sum_congr rfl fun g _ => Finset.sum_comm
    _ = ∑ d : Fin n, ∑ a : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h :=
        Finset.sum_congr rfl fun d _ => Finset.sum_comm
    _ = ∑ a : Fin n, ∑ d : Fin n, ∑ g : Fin n, ∑ h : Fin n, F a d g h := Finset.sum_comm

/-- **The BRST charge** `Ω = Σ_a c^a G_a − ½ f_{abc} c^a c^b b_c` of a family of first-class
constraints `G_a`. -/
def brstCharge (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R) (G : Fin n → R) : R :=
  (∑ a, χ a * G a) - (1 / 2 : ℝ) • Q f χ β

/-- **Nilpotency of the full BRST charge.**  If the ghosts obey the CAR, the constraints
commute with the ghosts and close with real structure constants that are antisymmetric and
satisfy the Jacobi identity, then `Ω² = 0` — the fact that makes the BRST cohomology, hence
the physical (gauge-invariant) sector, well defined. -/
theorem brstCharge_nilpotent (f : Fin n → Fin n → Fin n → ℝ) (χ β G : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hGχ : ∀ a b, G a * χ b = χ b * G a) (hGβ : ∀ a b, G a * β b = β b * G a)
    (hclose : ∀ a b, G a * G b - G b * G a = ∑ c, f a b c • G c)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    brstCharge f χ β G * brstCharge f χ β G = 0 := by
  classical
  -- the two halves of the charge
  set X : R := ∑ a, χ a * G a with hXdef
  -- moving a ghost creation operator through a cubic ghost monomial
  have hmove : ∀ a d g h : Fin n,
      χ a * (χ d * χ g * β h) + (χ d * χ g * β h) * χ a
        = (if h = a then (1 : R) else 0) * (χ d * χ g) := by
    intro a d g h
    have hb : β h * χ a = (if h = a then (1 : R) else 0) - χ a * β h :=
      eq_sub_of_add_eq (hCAR.betachi h a)
    have hda : χ d * χ a = -(χ a * χ d) := eq_neg_of_add_eq_zero_left (hCAR.chichi d a)
    have hga : χ g * χ a = -(χ a * χ g) := eq_neg_of_add_eq_zero_left (hCAR.chichi g a)
    have h3 : χ d * χ g * χ a = χ a * (χ d * χ g) := by
      calc χ d * χ g * χ a = χ d * (χ g * χ a) := by noncomm_ring
        _ = χ d * -(χ a * χ g) := by rw [hga]
        _ = -((χ d * χ a) * χ g) := by noncomm_ring
        _ = -((-(χ a * χ d)) * χ g) := by rw [hda]
        _ = χ a * (χ d * χ g) := by noncomm_ring
    have key : (χ d * χ g * β h) * χ a
        = (if h = a then (1 : R) else 0) * (χ d * χ g) - χ a * (χ d * χ g * β h) := by
      have h1 : (χ d * χ g * β h) * χ a = χ d * χ g * (β h * χ a) := by noncomm_ring
      rw [h1, hb]
      have h2 : χ d * χ g * ((if h = a then (1 : R) else 0) - χ a * β h)
          = (if h = a then (1 : R) else 0) * (χ d * χ g) - (χ d * χ g * χ a) * β h := by
        by_cases hh : h = a
        · simp only [hh, if_pos]; noncomm_ring
        · simp only [if_neg hh]; noncomm_ring
      rw [h2, h3]
      noncomm_ring
    rw [key]
    abel
  -- the square of the linear part
  have hXXexp : X * X = ∑ a, ∑ b, (χ a * χ b) * (G a * G b) := by
    rw [hXdef, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [show (χ a * G a) * (χ b * G b) = χ a * (G a * χ b) * G b by noncomm_ring, hGχ a b]
    noncomm_ring
  have hswap : (∑ a, ∑ b, (χ a * χ b) * (G b * G a))
      = -∑ a, ∑ b, (χ a * χ b) * (G a * G b) := by
    rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [show χ b * χ a = -(χ a * χ b) from eq_neg_of_add_eq_zero_left (hCAR.chichi b a)]
    noncomm_ring
  have hXX2 : (2 : ℝ) • (X * X) = ∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * G c) := by
    rw [two_smul, hXXexp]
    nth_rewrite 2 [show (∑ a, ∑ b, (χ a * χ b) * (G a * G b))
        = -∑ a, ∑ b, (χ a * χ b) * (G b * G a) from by rw [hswap, neg_neg]]
    rw [← sub_eq_add_neg, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [← mul_sub, hclose a b, Finset.mul_sum]
    exact Finset.sum_congr rfl fun c _ => by rw [mul_smul_comm]
  -- the cross term
  have hXQ : X * Q f χ β + Q f χ β * X = ∑ a, ∑ b, ∑ c, f a b c • (χ a * χ b * G c) := by
    have hX1 : X * Q f χ β
        = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((χ a * G a) * (χ d * χ g * β h)) := by
      rw [hXdef, Q, Finset.sum_mul]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun h _ => by rw [mul_smul_comm]
    have hQ1 : Q f χ β * X
        = ∑ a, ∑ d, ∑ g, ∑ h, f d g h • ((χ d * χ g * β h) * (χ a * G a)) := by
      rw [← sum_rotate4 (fun a d g h => f d g h • ((χ d * χ g * β h) * (χ a * G a)))]
      rw [hXdef, Q, Finset.sum_mul]
      refine Finset.sum_congr rfl fun d _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [Finset.sum_mul]
      refine Finset.sum_congr rfl fun h _ => ?_
      rw [smul_mul_assoc, Finset.mul_sum, Finset.smul_sum]
    rw [hX1, hQ1, ← Finset.sum_add_distrib]
    have hcollapse : ∀ a : Fin n,
        ((∑ d, ∑ g, ∑ h, f d g h • ((χ a * G a) * (χ d * χ g * β h)))
          + ∑ d, ∑ g, ∑ h, f d g h • ((χ d * χ g * β h) * (χ a * G a)))
        = ∑ d, ∑ g, f d g a • (χ d * χ g * G a) := by
      intro a
      simp only [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun d _ => ?_
      refine Finset.sum_congr rfl fun g _ => ?_
      have hterm : ∀ h : Fin n,
          f d g h • ((χ a * G a) * (χ d * χ g * β h))
            + f d g h • ((χ d * χ g * β h) * (χ a * G a))
          = f d g h • ((if h = a then (1 : R) else 0) * (χ d * χ g * G a)) := by
        intro h
        rw [← smul_add]
        congr 1
        have hc1 : (χ a * G a) * (χ d * χ g * β h) = (χ a * (χ d * χ g * β h)) * G a := by
          have hg1 : G a * (χ d * χ g * β h) = (χ d * χ g * β h) * G a := by
            rw [show G a * (χ d * χ g * β h) = ((G a * χ d) * χ g) * β h by noncomm_ring,
              hGχ a d,
              show ((χ d * G a) * χ g) * β h = (χ d * (G a * χ g)) * β h by noncomm_ring,
              hGχ a g,
              show (χ d * (χ g * G a)) * β h = (χ d * χ g) * (G a * β h) by noncomm_ring,
              hGβ a h]
            noncomm_ring
          calc (χ a * G a) * (χ d * χ g * β h)
              = χ a * (G a * (χ d * χ g * β h)) := by noncomm_ring
            _ = χ a * ((χ d * χ g * β h) * G a) := by rw [hg1]
            _ = (χ a * (χ d * χ g * β h)) * G a := by noncomm_ring
        have hc2 : (χ d * χ g * β h) * (χ a * G a)
            = ((χ d * χ g * β h) * χ a) * G a := by noncomm_ring
        rw [hc1, hc2, ← add_mul, hmove a d g h]
        noncomm_ring
      rw [Finset.sum_congr rfl fun h (_ : h ∈ Finset.univ) => hterm h]
      rw [Finset.sum_eq_single a]
      · rw [if_pos rfl, one_mul]
      · intro h _ hh
        rw [if_neg hh, zero_mul, smul_zero]
      · intro ha
        exact absurd (Finset.mem_univ a) ha
    rw [Finset.sum_congr rfl fun a (_ : a ∈ Finset.univ) => hcollapse a]
    rw [← sum_rotate3 (fun a d g => f d g a • (χ d * χ g * G a))]
  -- nilpotency of the cubic ghost term
  have hQnil : Q f χ β * Q f χ β = 0 := brst_charge_nilpotent f χ β hCAR hf12 hjac
  -- assemble
  have h2 : (2 : ℝ) • (brstCharge f χ β G * brstCharge f χ β G) = 0 := by
    have hexp : brstCharge f χ β G * brstCharge f χ β G
        = X * X - (1 / 2 : ℝ) • (X * Q f χ β + Q f χ β * X)
          + (1 / 2 : ℝ) • ((1 / 2 : ℝ) • (Q f χ β * Q f χ β)) := by
      rw [brstCharge, ← hXdef]
      simp only [sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm, smul_add, smul_sub]
      abel
    have htwo : ((2 : ℝ) * (1 / 2 : ℝ)) = 1 := by norm_num
    rw [hexp, hQnil, smul_zero, smul_zero, add_zero, smul_sub, smul_smul, htwo, one_smul,
      hXX2, hXQ, sub_self]
  have hne : (2 : ℝ) ≠ 0 := two_ne_zero
  rcases smul_eq_zero.mp h2 with h | h
  · exact absurd h hne
  · exact h

/-! ## 4. The Gauss-law constraints: second quantization as a Lie homomorphism -/

variable {N : ℕ}

/-- The commutator of two occupation bilinears, from the canonical anticommutation
relations. -/
theorem creat_annih_commutator (i j k l : Fin N) :
    (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        - (creat k * annih l) * (creat i * annih j)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by
  have e1 : (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
      = (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - creat i * creat k * (annih j * annih l) := by
    have h0 : (creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l)
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * creat k) * annih l := by
      noncomm_ring
    rw [h0, annih_mul_creat j k]
    by_cases h : j = k
    · rw [if_pos h, if_pos h]; noncomm_ring
    · rw [if_neg h, if_neg h]; noncomm_ring
  have e2 : (creat k * annih l : Module.End ℂ (FermiFock N)) * (creat i * annih j)
      = (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
        - creat k * creat i * (annih l * annih j) := by
    have h0 : (creat k * annih l : Module.End ℂ (FermiFock N)) * (creat i * annih j)
        = creat k * ((annih l : Module.End ℂ (FermiFock N)) * creat i) * annih j := by
      noncomm_ring
    rw [h0, annih_mul_creat l i]
    by_cases h : l = i
    · rw [if_pos h, if_pos h]; noncomm_ring
    · rw [if_neg h, if_neg h]; noncomm_ring
  have e3 : (creat k * creat i : Module.End ℂ (FermiFock N)) * (annih l * annih j)
      = creat i * creat k * (annih j * annih l) := by
    rw [creat_mul_creat k i, annih_mul_annih l j]
    noncomm_ring
  rw [e1, e2, e3]
  abel

/-- The second quantization written with the ring multiplication of `Module.End`. -/
theorem fermiBilin_eq4 (M : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N))
      = ∑ i : Fin N, ∑ j : Fin N, M i j • (creat i * annih j) := rfl

theorem fermiBilin_sub (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (M - P) : Module.End ℂ (FermiFock N)) = fermiBilin M - fermiBilin P := by
  rw [fermiBilin_eq4, fermiBilin_eq4, fermiBilin_eq4, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_sub_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [Matrix.sub_apply, sub_smul]

theorem fermiBilin_mul4 (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin M : Module.End ℂ (FermiFock N)) * fermiBilin P
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (M i j * P k l) • ((creat i * annih j) * (creat k * annih l)) := by
  rw [fermiBilin_eq4, fermiBilin_eq4, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [smul_mul_assoc, mul_smul_comm, smul_smul]

/-- Swapping the two index pairs of a fourfold sum. -/
theorem sum4_swap (F : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N)) :
    ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
  calc ∑ k : Fin N, ∑ l : Fin N, ∑ i : Fin N, ∑ j : Fin N, F i j k l
      = ∑ q : Fin N × Fin N, ∑ p : Fin N × Fin N, F p.1 p.2 q.1 q.2 := by
        simp [Fintype.sum_prod_type]
    _ = ∑ p : Fin N × Fin N, ∑ q : Fin N × Fin N, F p.1 p.2 q.1 q.2 := Finset.sum_comm
    _ = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, F i j k l := by
        simp [Fintype.sum_prod_type]

/-- The first delta contraction of the commutator sum. -/
theorem sum_delta_left (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (M * P) := by
  have step1 : ∀ i j : Fin N,
      (∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0))
        = ∑ l : Fin N, (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
    intro i j
    rw [Finset.sum_eq_single j]
    · exact Finset.sum_congr rfl fun l _ => by rw [if_pos rfl]
    · intro k _ hk
      exact Finset.sum_eq_zero fun l _ => by rw [if_neg (Ne.symm hk), smul_zero]
    · intro hj
      exact absurd (Finset.mem_univ j) hj
  calc ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ l : Fin N,
          (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => step1 i j
    _ = ∑ i : Fin N, ∑ l : Fin N, ∑ j : Fin N,
          (M i j * P j l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ i : Fin N, ∑ l : Fin N,
          ((M * P) i l) • (creat i * annih l : Module.End ℂ (FermiFock N)) := by
        refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
    _ = fermiBilin (M * P) := (fermiBilin_eq4 (M * P)).symm

/-- The second delta contraction of the commutator sum. -/
theorem sum_delta_right (M P : Matrix (Fin N) (Fin N) ℂ) :
    ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = fermiBilin (P * M) := by
  have step1 : ∀ i j k : Fin N,
      (∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0))
        = (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
    intro i j k
    rw [Finset.sum_eq_single i]
    · rw [if_pos rfl]
    · intro l _ hl
      rw [if_neg hl, smul_zero]
    · intro hi
      exact absurd (Finset.mem_univ i) hi
  calc ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
        (M i j * P k l) • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
          Finset.sum_congr rfl fun k _ => step1 i j k
    _ = ∑ i : Fin N, ∑ k : Fin N, ∑ j : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k : Fin N, ∑ i : Fin N, ∑ j : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := Finset.sum_comm
    _ = ∑ k : Fin N, ∑ j : Fin N, ∑ i : Fin N,
          (M i j * P k i) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k : Fin N, ∑ j : Fin N,
          ((P * M) k j) • (creat k * annih j : Module.End ℂ (FermiFock N)) := by
        refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
        rw [← Finset.sum_smul, Matrix.mul_apply]
        congr 1
        exact Finset.sum_congr rfl fun i _ => by ring
    _ = fermiBilin (P * M) := (fermiBilin_eq4 (P * M)).symm

/-- **Second quantization is a Lie-algebra homomorphism**: `[dΓ(A), dΓ(B)] = dΓ([A,B])`. -/
theorem fermiBilin_lie (A B : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * fermiBilin B
        - fermiBilin B * fermiBilin A
      = fermiBilin (A * B - B * A) := by
  have h2 : (fermiBilin B : Module.End ℂ (FermiFock N)) * fermiBilin A
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N,
          (A i j * B k l) • ((creat k * annih l) * (creat i * annih j)) := by
    rw [fermiBilin_mul4 B A,
      ← sum4_swap (fun i j k l =>
        (A i j * B k l) • ((creat k * annih l : Module.End ℂ (FermiFock N))
          * (creat i * annih j)))]
    exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [mul_comm]
  rw [fermiBilin_mul4 A B, h2]
  have hcomb : ∀ X Y : Fin N → Fin N → Fin N → Fin N → Module.End ℂ (FermiFock N),
      (∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, X i j k l)
        - (∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, Y i j k l)
      = ∑ i : Fin N, ∑ j : Fin N, ∑ k : Fin N, ∑ l : Fin N, (X i j k l - Y i j k l) := by
    intro X Y
    simp only [← Finset.sum_sub_distrib]
  rw [hcomb]
  have hterm : ∀ i j k l : Fin N,
      ((A i j * B k l) • ((creat i * annih j : Module.End ℂ (FermiFock N)) * (creat k * annih l))
        - (A i j * B k l) • ((creat k * annih l : Module.End ℂ (FermiFock N))
            * (creat i * annih j)))
      = (A i j * B k l) • (if j = k then (creat i * annih l : Module.End ℂ (FermiFock N)) else 0)
        - (A i j * B k l)
            • (if l = i then (creat k * annih j : Module.End ℂ (FermiFock N)) else 0) := by
    intro i j k l
    rw [← smul_sub, ← smul_sub, creat_annih_commutator i j k l]
  rw [Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => Finset.sum_congr rfl
    fun j (_ : j ∈ Finset.univ) => Finset.sum_congr rfl fun k (_ : k ∈ Finset.univ) =>
      Finset.sum_congr rfl fun l (_ : l ∈ Finset.univ) => hterm i j k l]
  rw [← hcomb, sum_delta_left A B, sum_delta_right A B, ← fermiBilin_sub]

/-- A second-quantized operator whose `k`-th column vanishes commutes with the creation
operator of the mode `k`: bilinears are even. -/
theorem fermiBilin_comm_creat {A : Matrix (Fin N) (Fin N) ℂ} {k : Fin N}
    (hcol : ∀ i, A i k = 0) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * creat k
      = creat k * fermiBilin A := by
  rw [fermiBilin_eq4, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases h : j = k
  · subst h
    rw [hcol i, zero_smul, zero_mul, mul_zero]
  · rw [smul_mul_assoc, mul_smul_comm]
    congr 1
    have h1 : (annih j : Module.End ℂ (FermiFock N)) * creat k = -(creat k * annih j) := by
      rw [annih_mul_creat j k, if_neg h, zero_sub]
    calc (creat i * annih j : Module.End ℂ (FermiFock N)) * creat k
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * creat k) := by noncomm_ring
      _ = creat i * -(creat k * annih j) := by rw [h1]
      _ = -((creat i : Module.End ℂ (FermiFock N)) * creat k) * annih j := by noncomm_ring
      _ = -(-((creat k : Module.End ℂ (FermiFock N)) * creat i)) * annih j := by
            rw [creat_mul_creat i k]
      _ = creat k * (creat i * annih j) := by noncomm_ring

/-- A second-quantized operator whose `k`-th row vanishes commutes with the annihilation
operator of the mode `k`. -/
theorem fermiBilin_comm_annih {A : Matrix (Fin N) (Fin N) ℂ} {k : Fin N}
    (hrow : ∀ j, A k j = 0) :
    (fermiBilin A : Module.End ℂ (FermiFock N)) * annih k
      = annih k * fermiBilin A := by
  rw [fermiBilin_eq4, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases h : i = k
  · subst h
    rw [hrow j, zero_smul, zero_mul, mul_zero]
  · rw [smul_mul_assoc, mul_smul_comm]
    congr 1
    have h1 : (annih k : Module.End ℂ (FermiFock N)) * creat i = -(creat i * annih k) := by
      rw [annih_mul_creat k i, if_neg (fun hh => h hh.symm), zero_sub]
    calc (creat i * annih j : Module.End ℂ (FermiFock N)) * annih k
        = creat i * ((annih j : Module.End ℂ (FermiFock N)) * annih k) := by noncomm_ring
      _ = creat i * -((annih k : Module.End ℂ (FermiFock N)) * annih j) := by
            rw [annih_mul_annih j k]
      _ = -((creat i : Module.End ℂ (FermiFock N)) * annih k) * annih j := by noncomm_ring
      _ = ((annih k : Module.End ℂ (FermiFock N)) * creat i) * annih j := by rw [← h1]
      _ = annih k * (creat i * annih j) := by noncomm_ring

/-- Second quantization is linear in the one-particle matrix. -/
theorem fermiBilin_smul (c : ℂ) (M : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (c • M) : Module.End ℂ (FermiFock N)) = c • fermiBilin M := by
  rw [fermiBilin_eq4, fermiBilin_eq4, Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.smul_sum]
  exact Finset.sum_congr rfl fun j _ => by rw [Matrix.smul_apply, smul_eq_mul, mul_smul]

/-- Second quantization is additive in the one-particle matrix. -/
theorem fermiBilin_add' (M P : Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (M + P) : Module.End ℂ (FermiFock N)) = fermiBilin M + fermiBilin P := by
  rw [fermiBilin_eq4, fermiBilin_eq4, fermiBilin_eq4, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [Matrix.add_apply, add_smul]

/-- Second quantization commutes with finite sums of one-particle matrices. -/
theorem fermiBilin_sum {ι : Type*} (s : Finset ι) (M : ι → Matrix (Fin N) (Fin N) ℂ) :
    (fermiBilin (∑ t ∈ s, M t) : Module.End ℂ (FermiFock N))
      = ∑ t ∈ s, fermiBilin (M t) := by
  classical
  induction s using Finset.induction with
  | empty =>
      rw [Finset.sum_empty, Finset.sum_empty, fermiBilin_eq4]
      refine Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => ?_
      simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, ← ih]
      exact fermiBilin_add' (M a) (∑ t ∈ s, M t)

/-! ## 5. The Standard-Model BRST charge -/

/-- The matter block of a one-particle operator, embedded in the joint matter ⊗ ghost mode
set: the operator acts on the first `m` modes and annihilates the ghosts. -/
def embedMatter (m : ℕ) (M : Matrix (Fin m) (Fin m) ℂ) :
    Matrix (Fin (m + 12)) (Fin (m + 12)) ℂ :=
  Matrix.reindex finSumFinEquiv finSumFinEquiv (Matrix.fromBlocks M 0 0 0)

/-- **The Gauss-law generator** of the `a`-th gauge direction: the second quantization
`−i dΓ(T_a)` of the one-particle generator on the matter modes. -/
def matterGen (m : ℕ) (T : Fin 12 → Matrix (Fin m) (Fin m) ℂ) (a : Fin 12) :
    Module.End ℂ (FermiFock (m + 12)) :=
  (-Complex.I) • fermiBilin (embedMatter m (T a))

/-- The embedded matter block has no entry in a ghost column. -/
theorem embedMatter_col_ghost (m : ℕ) (M : Matrix (Fin m) (Fin m) ℂ) (b : Fin 12)
    (i : Fin (m + 12)) : embedMatter m M i (ghostMode m b) = 0 := by
  rcases h : finSumFinEquiv.symm i with u | u <;>
    simp [embedMatter, ghostMode, Matrix.reindex_apply, Matrix.submatrix_apply, h]

/-- The embedded matter block has no entry in a ghost row. -/
theorem embedMatter_row_ghost (m : ℕ) (M : Matrix (Fin m) (Fin m) ℂ) (b : Fin 12)
    (j : Fin (m + 12)) : embedMatter m M (ghostMode m b) j = 0 := by
  rcases h : finSumFinEquiv.symm j with u | u <;>
    simp [embedMatter, ghostMode, Matrix.reindex_apply, Matrix.submatrix_apply, h]

/-- Embedding the matter block is multiplicative. -/
theorem embedMatter_mul (m : ℕ) (M P : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m M * embedMatter m P = embedMatter m (M * P) := by
  simp only [embedMatter, Matrix.reindex_apply]
  rw [Matrix.submatrix_mul_equiv (Matrix.fromBlocks M 0 0 0) (Matrix.fromBlocks P 0 0 0)
    finSumFinEquiv.symm finSumFinEquiv.symm finSumFinEquiv.symm]
  congr 1
  rw [Matrix.fromBlocks_multiply]
  simp

/-- Embedding the matter block is compatible with subtraction. -/
theorem embedMatter_sub (m : ℕ) (M P : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (M - P) = embedMatter m M - embedMatter m P := by
  ext i j
  simp only [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply, Matrix.sub_apply]
  rcases finSumFinEquiv.symm i with u | u <;> rcases finSumFinEquiv.symm j with v | v <;> simp

/-- Embedding the matter block is compatible with scalar multiplication. -/
theorem embedMatter_smul (m : ℕ) (c : ℂ) (M : Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (c • M) = c • embedMatter m M := by
  ext i j
  simp only [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply, Matrix.smul_apply,
    smul_eq_mul]
  rcases finSumFinEquiv.symm i with u | u <;> rcases finSumFinEquiv.symm j with v | v <;> simp

/-- Embedding the matter block is compatible with finite sums. -/
theorem embedMatter_sum {m : ℕ} {ι : Type*} (s : Finset ι) (M : ι → Matrix (Fin m) (Fin m) ℂ) :
    embedMatter m (∑ t ∈ s, M t) = ∑ t ∈ s, embedMatter m (M t) := by
  classical
  induction s using Finset.induction with
  | empty =>
      ext i j
      simp [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply]
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, ← ih]
      ext i j
      simp only [embedMatter, Matrix.reindex_apply, Matrix.submatrix_apply, Matrix.add_apply]
      rcases finSumFinEquiv.symm i with u | u <;> rcases finSumFinEquiv.symm j with v | v <;> simp

/-- **The Gauss-law generators close with the real structure constants.** -/
theorem matterGen_lie {m : ℕ} {T : Fin 12 → Matrix (Fin m) (Fin m) ℂ}
    {f : Fin 12 → Fin 12 → Fin 12 → ℝ} (hT : ClosesWithStructureConstants T f) (a b : Fin 12) :
    matterGen m T a * matterGen m T b - matterGen m T b * matterGen m T a
      = ∑ c, f a b c • matterGen m T c := by
  have hstep : matterGen m T a * matterGen m T b - matterGen m T b * matterGen m T a
      = ((-Complex.I) * (-Complex.I)) •
          (fermiBilin (embedMatter m (T a * T b - T b * T a))
            : Module.End ℂ (FermiFock (m + 12))) := by
    rw [matterGen, matterGen, smul_mul_smul_comm, smul_mul_smul_comm, ← smul_sub,
      fermiBilin_lie, embedMatter_mul, embedMatter_mul, ← embedMatter_sub]
  rw [hstep, hT a b, embedMatter_smul, fermiBilin_smul, embedMatter_sum, fermiBilin_sum,
    smul_smul, Finset.smul_sum]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [embedMatter_smul, fermiBilin_smul, matterGen, smul_smul, ← Complex.coe_smul, smul_smul]
  congr 1
  have hII : (-Complex.I) * (-Complex.I) = -1 := by rw [neg_mul_neg, Complex.I_mul_I]
  rw [hII]
  ring



/-- The Gauss-law generators commute with the ghost annihilation operators. -/
theorem matterGen_comm_ghostAnn (m : ℕ) (T : Fin 12 → Matrix (Fin m) (Fin m) ℂ) (a b : Fin 12) :
    matterGen m T a * ghostAnn m b = ghostAnn m b * matterGen m T a := by
  rw [matterGen, ghostAnn, smul_mul_assoc, mul_smul_comm,
    fermiBilin_comm_annih (fun j => embedMatter_row_ghost m (T a) b j)]

/-- **The Standard-Model BRST charge** on the joint matter ⊗ ghost Fock space. -/
def smBrstCharge (m : ℕ) (T : Fin 12 → Matrix (Fin m) (Fin m) ℂ)
    (f3 : Fin 8 → Fin 8 → Fin 8 → ℝ) : Module.End ℂ (FermiFock (m + 12)) :=
  brstCharge (smStruct f3) (ghostCre m) (ghostAnn m) (matterGen m T)

/-- **The Standard-Model BRST charge is nilpotent**: `Ω² = 0`.  The gauge algebra
`su(3) ⊕ su(2) ⊕ u(1)`, its Gauss-law generators on the matter CAR algebra and the twelve
ghosts assemble into a nilpotent charge, so the BRST cohomology — the physical sector of the
gauge-fixed Standard-Model Hamiltonian — is well defined. -/
theorem smBrstCharge_nilpotent {m : ℕ} {T : Fin 12 → Matrix (Fin m) (Fin m) ℂ}
    {f3 : Fin 8 → Fin 8 → Fin 8 → ℝ} (hT : ClosesWithStructureConstants T (smStruct f3))
    (h3anti : ∀ a b c, f3 a b c = -f3 b a c)
    (h3jac : ∀ a b c h : Fin 8, ∑ e, (f3 a b e * f3 e c h + f3 b c e * f3 e a h
      + f3 c a e * f3 e b h) = 0) :
    smBrstCharge m T f3 * smBrstCharge m T f3 = 0 :=
  brstCharge_nilpotent (smStruct f3) (ghostCre m) (ghostAnn m) (matterGen m T) (smGhostCAR m)
    (matterGen_comm_ghostCre m T) (matterGen_comm_ghostAnn m T)
    (fun a b => matterGen_lie hT a b) (smStruct_antisymm h3anti) (smStruct_jacobi h3jac)

end

end BookProof.SmBrstGhost
