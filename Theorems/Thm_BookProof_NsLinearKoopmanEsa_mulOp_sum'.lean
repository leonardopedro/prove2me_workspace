-- Generated from ChapterNsLinearKoopmanEsa.lean — theorem BookProof.NsLinearKoopmanEsa.mulOp_sum'
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterQuadraticFockEsa
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Definitions.Def_ChapterF7
open BookProof.ChapterF7
open BookProof.NsLinearKoopmanEsa

variable {d : ℕ}



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section


theorem BookProof.NsLinearKoopmanEsa.mulOp_sum_prime {ι : Type*} (s : Finset ι) (f : ι → MvPolynomial (Fin d) ℂ) :
    mulOp (∑ j ∈ s, f j) = ∑ j ∈ s, mulOp (f j) := by sorry
