-- Generated from ChapterVielbeinFiberFock.lean — theorem BookProof.VielbeinFock.vielbeinManyPotential_apply
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronFockEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky
open BookProof.VielbeinFock


open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.VielbeinFock.vielbeinManyPotential_apply (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) (n : ℕ)
    (x : vielbeinSector d n) :
    vielbeinManyPotential M alpha d om n x
      = ∑ j : Fin n, ((∑ i : Fin d, om i ^ 2 / 2 * (x (j, i.castSucc)) ^ 2)
        + starobinskyV M alpha (x (j, Fin.last d))) := by sorry
