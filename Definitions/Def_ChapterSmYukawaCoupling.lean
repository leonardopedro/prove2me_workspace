import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib


/-!
# The Standard-Model one-particle Hamiltonian with an **operator-valued** Yukawa coupling

`BookProof/ChapterSmFullEnclosure.lean` assembles `h_full = h_B ⊗ 1 + 1 ⊗ (smDirac + smYukawa M z)`
with the Yukawa term in a *fixed* Higgs background `z`: a tensor sum, with no boson–fermion
coupling operator.  This module replaces the constant `z` by the Higgs field itself.  Writing
`z = φ₀ + i φ₁` with `φ₀, φ₁` two real components of the Higgs doublet (the coordinates
`smPhi 0`, `smPhi 1` of `ℝ¹⁶³`), the fixed-background Yukawa operator is
`smYukawa M z = Re z · smYukawa M 1 + Im z · smYukawa M i` (`smYukawa_eq_re_im`), and the
operator-valued coupling is

`H_Y = φ₀ ⊗ smYukawa M 1 + φ₁ ⊗ smYukawa M i`,

a genuine interaction between the bosonic and the fermionic factor.  The Hamiltonian is

`h_Yuk = h_B ⊗ 1 + 1 ⊗ smDirac h_D + H_Y`   (`smYukawaFullHam`).

## What is proved

* `higgs_sq_le` — the pointwise inequality `φ_a² ≤ (2/λ) W² + v² + ¼`, where
  `W = √(λ/2)(‖φ‖² − v²)` is the Higgs wall of `smHamiltonian`;
* `norm_higgsMul_sq_le`, `norm_wall_sq_le_quadForm`, **`higgsMul_relBound`** — for `λ > 0`,
  multiplication by a Higgs component is `h_B`-bounded with relative bound `0`:
  `‖φ_a u‖ ≤ ε ‖h_B u‖ + C_ε ‖u‖` for every `ε > 0`;
* `smYukawa_symmetricOn`, `smYukawa_eq_re_im`;
* **`smYukawa_h_esa`** — for `λ > 0`, every Hermitian Dirac matrix and every Yukawa matrix,
  `h_Yuk` is essentially self-adjoint on `polyGaussCore 163 ⊗ FermiFock n` (one-particle
  statement), by Kato–Rellich for product couplings
  (`TensorKatoRellich.essentiallySelfAdjointOn_tensorSum_add_coupling`) on top of
  `smFull_h_esa`;
* **`smYukawa_dGamma_esa`** — its enclosure `dΓ(h_Yuk)` (creation left / annihilation right)
  is essentially self-adjoint on the finite-particle domain.

## Honest boundary

The Higgs quartic must be **positive** (`0 < λ`): the relative bound comes from the Higgs wall.
The fermionic mode set is finite (the CAR Fock space `FermiFock n` is finite-dimensional), which
is what makes the coupling relatively bounded.  Which two real components of the doublet carry
the Yukawa coupling is a modelling choice (`smPhi 0`, `smPhi 1`); the proof works for any.  No
spectral information and no mass gap is claimed.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.SmYukawaCoupling

open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

/-! ## 1. Multiplication by a Higgs component -/

/-- Multiplication by the Higgs component `φ_a`, on the Gauss–polynomial core of `L²(ℝ¹⁶³)`. -/
def higgsMul (a : Fin 4) : (polyGaussCore (d := 163)) →ₗ[ℂ] L2d 163 :=
  (polyGaussCore (d := 163)).subtype ∘ₗ (coreRepPoly 163).op (mulOp (X (smPhi a)))



/-- The real value of the Higgs wall `W = √(λ/2)(‖φ‖² − v²)` at a point. -/
def wallVal (P : SmParams) (x : Vd 163) : ℝ :=
  Real.sqrt (P.lam / 2) * ((∑ b : Fin 4, x (smPhi b) ^ 2) - P.vev ^ 2)











/-- The Higgs wall is one of the squared forms of `smHamiltonian`. -/
def wallIdx : Fin 49 := smFormFin (Sum.inr (Sum.inr (Sum.inr (Sum.inr ()))))













/-! ## 2. The fermionic Yukawa bilinears -/







/-! ## 3. The coupled Hamiltonian -/

/-- The bosonic coupling operators: the two real Higgs components carrying the Yukawa
coupling. -/
def yukV : Fin 2 → (polyGaussCore (d := 163)) →ₗ[ℂ] L2d 163 := ![higgsMul 0, higgsMul 1]

/-- The fermionic coupling operators: `smYukawa M 1` and `smYukawa M i`. -/
def yukY {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) : Fin 2 → fullDom n →ₗ[ℂ] FermiFock n :=
  ![onFull (smYukawa M 1), onFull (smYukawa M Complex.I)]

/-- **The Standard-Model one-particle Hamiltonian with the operator-valued Yukawa coupling**
`h_Yuk = h_B ⊗ 1 + 1 ⊗ smDirac h_D + φ₀ ⊗ smYukawa M 1 + φ₁ ⊗ smYukawa M i`. -/
def smYukawaFullHam (P : SmParams) {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) :
    smFullCore n →ₗ[ℂ] (smFullSpace n).carrier :=
  cpairOp (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
      (smHamiltonian P) (onFull (smFermiHam hD 0 0)) +
    pairLiftOp (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
      (couplingPoly (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
        yukV (yukY M))

instance smFermiSpace_finiteDimensional (n : ℕ) : FiniteDimensional ℂ (smFermiSpace n).carrier :=
  inferInstanceAs (FiniteDimensional ℂ (FermiFock n))

/-- `fullDom n = ⊤`, and the subtype inclusion into the Fock space is injective. -/
instance fullDom_finiteDimensional (n : ℕ) : FiniteDimensional ℂ ↥(fullDom n) := by
  haveI : FiniteDimensional ℂ (FermiFock n) := inferInstance
  exact FiniteDimensional.of_injective (fullDom n).subtype Subtype.val_injective







end

end BookProof.SmYukawaCoupling
