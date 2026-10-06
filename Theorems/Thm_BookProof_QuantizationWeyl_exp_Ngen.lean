-- Generated from ChapterQuantizationWeyl.lean — theorem BookProof.QuantizationWeyl.exp_Ngen
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl


open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

theorem BookProof.QuantizationWeyl.exp_Ngen (a b c : ℝ) :
    NormedSpace.exp (Ngen a b c) = Heis a b (c + a * b / 2) := by sorry
