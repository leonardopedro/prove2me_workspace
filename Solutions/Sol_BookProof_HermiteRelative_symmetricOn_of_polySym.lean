-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.symmetricOn_of_polySym
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreEquiv_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
import Theorems.Thm_BookProof_YangMillsHermite_inner_pgLp_pgLp
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteRelative




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

open BookProof.QgOuterFockCoreFL BookProof.QgOuterFockCoreFL.CoreData BookProof.YangMillsHermite
noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hT : BookProof.YangMillsHermite.PolySym T) :
    SymmetricOn (polyGaussCore (d := d))
      ((polyGaussCore (d := d)).subtype ∘ₗ coreOp T) := by

  intro x y
  obtain ⟨p, rfl⟩ : ∃ p, (coreEquiv (d := d)) p = x :=
    ⟨coreEquiv.symm x, coreEquiv.apply_symm_apply x⟩
  obtain ⟨q, rfl⟩ : ∃ q, (coreEquiv (d := d)) q = y :=
    ⟨coreEquiv.symm y, coreEquiv.apply_symm_apply y⟩
  have hx : (((polyGaussCore (d := d)).subtype ∘ₗ coreOp T) (coreEquiv p)) = pgLp (T p) :=
    coreOp_coe T p
  have hy : (((polyGaussCore (d := d)).subtype ∘ₗ coreOp T) (coreEquiv q)) = pgLp (T q) :=
    coreOp_coe T q
  rw [hx, hy, coreEquiv_coe, coreEquiv_coe, BookProof.YangMillsHermite.inner_pgLp_pgLp,
    BookProof.YangMillsHermite.inner_pgLp_pgLp]
  exact hT p q
