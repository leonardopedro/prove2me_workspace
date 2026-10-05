-- Generated from ChapterSmFullEnclosure.lean — theorem BookProof.SmFullEnclosure.smFullHam_tmul
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmHamiltonian
open BookProof.HermiteProductCore
open BookProof.SmCar
open BookProof.SmDiracYukawa
open BookProof.SmHamiltonian
open BookProof.SmFullEnclosure



open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

theorem BookProof.SmFullEnclosure.smFullHam_tmul (P : SmParams) {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ)
    (x : ↥(smFullCore n)) (u : ↥(polyGaussCore (d := 163))) (ψ : ↥(fullDom n))
    (hx : (x : (smFullSpace n).carrier)
      = pairEmb (L2dSpace 163) (smFermiSpace n)
          (inclPair (L2dSpace 163) (smFermiSpace n) (polyGaussCore (d := 163)) (fullDom n)
            (u ⊗ₜ[ℂ] ψ : ↥(polyGaussCore (d := 163)) ⊗[ℂ] ↥(fullDom n)))) :
    smFullHam P hD M z x
      = pairEmb (L2dSpace 163) (smFermiSpace n)
          ((smHamiltonian P) u ⊗ₜ[ℂ] (ψ : FermiFock n)
            + (u : L2d 163) ⊗ₜ[ℂ] (smDirac hD + smYukawa M z) ψ) := by sorry
