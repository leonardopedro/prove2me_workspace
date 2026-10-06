-- Generated from ChapterWignerSymmetry.lean — solution of BookProof.ChapterWignerSymmetry.imgBasis_apply
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry



open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}
variable {b : OrthonormalBasis ι ℂ E} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) (i : ι) :
    imgBasis b T o hT i = alignPhase b T o i • T (b i) := by

  haveI : Nonempty ι := ⟨o⟩
  haveI : FiniteDimensional ℂ E := Module.Basis.finiteDimensional_of_finite b.toBasis
  have h : ⇑(imgBasis b T o hT) = imgVec b T o := by
    rw [imgBasis, Module.Basis.coe_toOrthonormalBasis,
      coe_basisOfLinearIndependentOfCardEqFinrank]
  rw [h, imgVec]
